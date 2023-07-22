import 'dart:convert';

import 'package:hiring_task/models/login-models/gln_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class GLNServices {
  static List<GLNModel> gln = [];
  static Future<List<GLNModel>> getGLN(int userId) async {
    const baseUrl = '${BaseUrl.gs1}/api/member/gln';
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
        gln = (data['products'] as List)
            .map((e) => GLNModel.fromJson(e))
            .toList();
        return gln;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      rethrow;
    }
  }
}
