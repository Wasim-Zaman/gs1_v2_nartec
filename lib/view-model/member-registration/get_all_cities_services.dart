import 'dart:convert';

import 'package:hiring_task/models/member-registration/get_all_cities_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class GetAllCitiesServices {
  static List<GetAllCitiesModel> futureData = [];
  static Future<List<GetAllCitiesModel>> getData(int stateId) async {
    const String url = '${BaseUrl.gs1}/api/cities/by/state';
    final response = await http.post(Uri.parse(url),
        body: json.encode({
          "state_id": stateId,
        }),
        headers: {
          'Content-Type': 'application/json',
        });
    print("********************* state id: ${response.body}");
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body)['city'] as List;
      for (var element in responseBody) {
        futureData.add(GetAllCitiesModel.fromJson(element));
      }
      return futureData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
