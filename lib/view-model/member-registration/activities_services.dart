import 'dart:convert';

import 'package:hiring_task/models/member-registration/activities_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class ActivitiesService {
  static List<ActivitiesModel> listOfActivities = [];
  static Future<List<ActivitiesModel>> getActivities(String? cr_number) async {
    const baseUrl = '${BaseUrl.gs1WithPort}/api/GellCRBYCRNO';

    print('Wait....');
    final uri = Uri.parse(baseUrl);

    final response = await http.post(
      uri,
      body: json.encode(
        {
          "crno": cr_number,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Host': BaseUrl.hostWithPort,
      },
    );

    if (response.statusCode == 200) {
      // handle successful response
      final responseBody = json.decode(response.body) as List;
      print('responseBody: $responseBody');
      for (var element in responseBody) {
        listOfActivities.add(ActivitiesModel.fromJson(element));
      }

      return listOfActivities;
    } else {
      print('Error happended while loading data');
      // handle error response
      throw Exception('Error happended while loading data');
    }
  }
}
