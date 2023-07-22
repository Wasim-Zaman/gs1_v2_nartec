import 'dart:convert';

import 'package:hiring_task/models/login-models/dashboard_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class LoginServices {
  static Future<DashboardModel> confirmation(
    String email,
    String activity,
    String password,
    String generatedOTP,
    String memberOtp,
  ) async {
    const baseUrl = '${BaseUrl.gs1}/api/otp/confirmation';
    final uri = Uri.parse(baseUrl);
    return http.post(
      uri,
      body: json.encode(
        {
          // body should include email
          'email': email,
          'activity': activity,
          'password': password,
          'generated_otp': generatedOTP,
          'member_otp': memberOtp,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Host': BaseUrl.host,
      },
    ).then((response) {
      if (response.statusCode == 200) {
        // handle successful response

        final responseBody = json.decode(response.body) as Map<String, dynamic>;
        DashboardModel dashboardModel = DashboardModel.fromJson(responseBody);
        return dashboardModel;
      } else {
        throw Exception('Error happended while sending OTP');
      }
    });
  }

  static Future<Map<String, dynamic>> sendOTP(String email, String activity) {
    const baseUrl = '${BaseUrl.gs1}/api/send/otp';
    final uri = Uri.parse(baseUrl);
    return http.post(
      uri,
      body: json.encode(
        {
          // body should include email
          'email': email,
          'activity': activity,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Host': BaseUrl.host,
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IklyZmFuIiwiaWF0IjoxNTE2MjM5MDIyfQ.vx1SEIP27zyDm9NoNbJRrKo-r6kRaVHNagsMVTToU6A',
      },
    ).then((response) {
      if (response.statusCode == 200) {
        // handle successful response
        print('******* status code is fine');
        print('body: ${json.decode(response.body)}');
        final responseBody = json.decode(response.body) as Map<String, dynamic>;
        return responseBody;
      } else {
        throw Exception('Error happended while sending OTP');
      }
    });
  }

  static Future<Map<String, dynamic>> loginWithPassword(
      String email, String activity, String password) {
    const baseUrl = '${BaseUrl.gs1}/api/member/login';
    final uri = Uri.parse(baseUrl);
    return http.post(
      uri,
      body: json.encode(
        {
          // body should include email
          'email': email,
          'activity': activity,
          'password': password,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Host': BaseUrl.host,
      },
    ).then((response) {
      print(response.statusCode);
      print((response.body));
      if (response.statusCode == 200) {
        // handle successful response
        final responseBody = json.decode(response.body) as Map<String, dynamic>;
        return responseBody;
      } else if (response.statusCode == 422) {
        throw Exception('Please Wait For Admin Approval');
      } else {
        throw Exception('Error happended while logging in');
      }
    });
  }

  static Future<Map<String, dynamic>> getActivities({String? email}) async {
    const baseUrl = '${BaseUrl.gs1}/api/email/verification';

    final uri = Uri.parse(baseUrl);
    try {
      final response = await http.post(
        uri,
        body: json.encode({
          // body should include email
          'email': email,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Host': BaseUrl.host,
        },
      );

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        // handle successful response
        final responseBody = json.decode(response.body) as Map<String, dynamic>;
        return responseBody;
      } else if (response.statusCode == 404) {
        throw Exception('Something went wrong');
      } else if (response.statusCode == 500) {
        throw Exception(
            'Internal Server Error: ${response.statusCode} status code');
      } else if (response.statusCode == 422) {
        throw Exception('Please Wait For Admin Approval');
      } else {
        throw Exception('Error happended while loading data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
