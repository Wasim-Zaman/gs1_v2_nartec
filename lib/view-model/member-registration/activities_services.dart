import 'dart:convert';

import 'package:hiring_task/models/member-registration/get_all_cr_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class ActivitiesService {
  static List<GetAllCrActivitiesModel> listOfActivities = [];
  static Future<List<GetAllCrActivitiesModel>> getActivities(
      String? crNumber) async {
    const baseUrl = '${BaseUrl.gs1}/api/cr/activities';

    final uri = Uri.parse(baseUrl);

    final response = await http.post(
      uri,
      body: json.encode(
        {
          "cr_number": crNumber,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // handle successful response
      final responseBody = json.decode(response.body)['cr_activities'] as List;
      for (var element in responseBody) {
        listOfActivities.add(GetAllCrActivitiesModel.fromJson(element));
      }

      return listOfActivities;
    } else {
      throw Exception('Error happended while loading data');
    }
  }
}
