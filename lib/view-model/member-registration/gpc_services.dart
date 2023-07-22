import 'dart:convert';

import 'package:hiring_task/models/member-registration/gpc_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class GpcService {
  static Future<List<GPCModel>> getGPC(String keyword) async {
    const String url = '${BaseUrl.gs1WithPort}/api/serachGPC';
    List<GPCModel> futureData = [];

    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(
            <String, String>{'GPCKeyword': keyword},
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Host': BaseUrl.hostWithPort,
          });
      if (response.statusCode == 200) // ok
      {
        final responseBody = jsonDecode(response.body) as List;
        for (var element in responseBody) {
          futureData.add(GPCModel.fromJson(element));
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
