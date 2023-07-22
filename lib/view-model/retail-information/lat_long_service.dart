import 'dart:convert';

import 'package:hiring_task/models/lat_long_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class LatLongService {
  static Future<List<LatLongModel>> getFutureData({String? gtin}) async {
    List<LatLongModel> futureData = [];

    final response = await http.post(
      Uri.parse(URL.latLong),
      body: json.encode({
        "gtin": gtin,
      }),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Host": "gtrack.info",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final responseData = body['gtinMarkers'] as List;

      for (var element in responseData) {
        futureData.add(LatLongModel.fromJson(element));
      }
      return futureData;
    } else {
      return futureData;
    }
  }
}
