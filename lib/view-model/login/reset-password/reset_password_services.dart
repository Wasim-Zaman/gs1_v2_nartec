import 'dart:convert';

import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class ResetPasswordServices {
  static Future<void> forgotPassword(
    String email,
    String activity,
    String activityId,
  ) async {
    const baseUrl = '${BaseUrl.gs1}/api/member/forgot/password';
    final uri = Uri.parse(baseUrl);
    return http.post(
      uri,
      body: json.encode(
        {
          // body should include email
          'email': email,
          'activity': activity,
          'activityID': activityId,
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
      } else {
        throw Exception('Could not send code, please try again later');
      }
    });
  }

  // Verify OTP
  static Future<void> verifyCode(
    String email,
    String activity,
    String activityId,
    String code,
  ) async {
    const baseUrl = '${BaseUrl.gs1}/api/member/verify/forgot/password/code';
    final uri = Uri.parse(baseUrl);
    return http.post(
      uri,
      body: json.encode(
        {
          // body should include email
          'email': email,
          'activity': activity,
          'activityID': activityId,
          'code': code,
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
      } else {
        throw Exception('Could not verify code, please try again later');
      }
    }).catchError((error) {
      throw Exception(error);
    });
  }

  // Reset Password
  static Future<void> resetPassword(
    String email,
    String activity,
    String password,
    String confirmPassword,
    String activityId,
  ) async {
    const baseUrl = '${BaseUrl.gs1}/api/member/password/reset';
    final uri = Uri.parse(baseUrl);
    return http.post(
      uri,
      body: json.encode(
        {
          // body should include email
          'email': email,
          'activity': activity,
          'password': password,
          'password_confirmation': confirmPassword,
          'activityID': activityId,
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
      } else {
        throw Exception('Could not reset password, please try again later');
      }
    }).catchError((error) {
      throw Exception(error);
    });
  }
}
