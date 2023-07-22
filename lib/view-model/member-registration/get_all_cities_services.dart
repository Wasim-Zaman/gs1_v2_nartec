import 'dart:convert';

import 'package:hiring_task/models/member-registration/get_all_cities_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class GetAllCitiesServices {
  static List<GetAllCitiesModel> futureData = [];
  static Future<List<GetAllCitiesModel>> getData() async {
    const String url = '${BaseUrl.gs1WithPort}/api/GetAllCities';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body) as List;
      for (var element in responseBody) {
        futureData.add(GetAllCitiesModel.fromJson(element));
      }
      return futureData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
