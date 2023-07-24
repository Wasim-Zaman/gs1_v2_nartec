import 'dart:convert';

import 'package:hiring_task/models/member-registration/get_all_states_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class GetAllStatesServices {
  static List<GetAllStatesModel> futureData = [];
  static Future<List<GetAllStatesModel>> getList(int countryId) async {
    const String url = '${BaseUrl.gs1}/api/states/by/country';
    final response = await http.post(Uri.parse(url),
        body: json.encode({
          "country_id": countryId,
        }),
        headers: {
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body)['states'];
      for (var element in responseBody) {
        futureData.add(GetAllStatesModel.fromJson(element));
      }
      print("*********************** ${futureData.length}");
      return futureData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
