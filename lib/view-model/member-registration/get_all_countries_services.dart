import 'dart:convert';

import 'package:hiring_task/models/member-registration/get_all_countries.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class GetAllCountriesServices {
  static List<GetCountriesModel> futureData = [];
  static Future<List<GetCountriesModel>> getList() async {
    const String url = '${BaseUrl.gs1}/api/countries/list';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body)['countries'] as List;
      for (var element in responseBody) {
        futureData.add(GetCountriesModel.fromJson(element));
      }
      return futureData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
