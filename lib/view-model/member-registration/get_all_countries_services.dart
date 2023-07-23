import 'dart:convert';

import 'package:hiring_task/models/member-registration/get_all_countries.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class GetAllCountriesServices {
  static List<GetAllCountriesModel> futureData = [];
  static Future<List<GetAllCountriesModel>> getList() async {
    const String url = '${BaseUrl.gs1WithPort}/api/GetAllCountry';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body) as List;
      for (var element in responseBody) {
        futureData.add(GetAllCountriesModel.fromJson(element));
      }
      return futureData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
