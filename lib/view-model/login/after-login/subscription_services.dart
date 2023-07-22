import 'dart:convert';

import 'package:hiring_task/models/login-models/profile/subscription_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class SubscriptionServices {
  static Future<SubscritionModel> getSubscription(int userId) async {
    const baseUrl = '${BaseUrl.gs1}/api/member/subscription';
    final uri = Uri.parse(baseUrl);
    try {
      final response = await http.post(
        uri,
        body: json.encode(
          {
            'user_id': userId,
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
        return SubscritionModel.fromJson(data);
      } else if (response.statusCode == 404) {
        throw Exception('Data not found');
      } else if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)['message']);
      } else {
        throw Exception('Something went wrong');
      }
    } catch (error) {
      rethrow;
    }
  }
}
