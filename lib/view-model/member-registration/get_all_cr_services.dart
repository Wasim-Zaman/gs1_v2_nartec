import 'dart:convert';

import 'package:hiring_task/models/member-registration/get_all_cr_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class GetAllCrServices {
  static Future<List<GetAllCrActivitiesModel>> getAllCr() async {
    const String url = '${BaseUrl.gs1WithPort}/api/GellAllCR';
    List<GetAllCrActivitiesModel> futureData = [];

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Host': BaseUrl.hostWithPort,
        },
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body) as List;
        for (var element in responseBody) {
          futureData.add(GetAllCrActivitiesModel.fromJson(element));
        }
        return futureData;
      } else {
        throw Exception('Status code is not fine');
      }
    } catch (error) {
      throw Exception('Failed to load data');
    }
  }
}
