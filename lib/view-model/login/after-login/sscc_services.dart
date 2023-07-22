import 'dart:convert';

import 'package:hiring_task/models/login-models/sscc_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class SSCCServices {
  static List<SSCCModel> sscc = [];
  static Future<List<SSCCModel>> getSSCC(int userId) async {
    const baseUrl = '${BaseUrl.gs1}/api/member/sscc';
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
        sscc = (data['products'] as List)
            .map((e) => SSCCModel.fromJson(e))
            .toList();
        return sscc;
      } else if (response.statusCode == 404) {
        throw Exception('Record not found');
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      rethrow;
    }
  }
}
