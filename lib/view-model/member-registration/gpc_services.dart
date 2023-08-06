import 'dart:convert';

import 'package:hiring_task/models/member-registration/gpc_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class GpcService {
  static Future<List<GPCModel>> getGPC(String term) async {
    const String url = '${BaseUrl.gs1}/api/search/gcp';
    List<GPCModel> futureData = [];

    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(
            <String, String>{'term': term},
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Host': BaseUrl.hostWithPort,
          });
      print("status code is ${response.statusCode}");
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final gpcMap = responseBody['gpc'];
        for (var element in gpcMap) {
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
