import 'dart:convert';

import 'package:hiring_task/models/login-models/help_desk_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class HelpDeskServices {
  static List<HelpDeskModel> futureData = [];
  static Future<List<HelpDeskModel>> getData(int userId) async {
    const baseUrl = '${BaseUrl.gs1}/api/view/tickets';
    final uri = Uri.parse(baseUrl);
    try {
      final response = await http.post(
        uri,
        body: json.encode(
          {
            'user_id': userId.toString(),
          },
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Host': BaseUrl.host,
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        futureData.clear();
        data.forEach((element) {
          futureData.add(HelpDeskModel.fromJson(element));
        });
        return futureData;
      } else if (response.statusCode == 404) {
        throw Exception('Record not found');
      } else if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)['message']);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      rethrow;
    }
  }
}
