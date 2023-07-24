import 'dart:convert';

import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class ValidateCrServices {
  static Future<bool> validateCr(String cr) async {
    try {
      if (cr.length != 10) {
        return false;
      }
      final url = Uri.parse("${BaseUrl.gs1}/api/validate/cr/no");

      final response =
          await http.post(url, body: json.encode({"cr_number": cr}), headers: {
        'Content-Type': 'application/json',
      });

      print("response.statusCode ${response.statusCode}");

      if (response.statusCode != 200) {
        return false;
      }
    } catch (e) {
      return false;
    }
    return true;
  }
}
