import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hiring_task/models/safety_info_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class ProductSafetyServices {
  static Future<List<SafetyInfoModel>> getFutureData(BuildContext context,
      {String? gtin}) async {
    List<SafetyInfoModel> futureData = [];

    final response = await http.post(
      Uri.parse(URL.digitalLink),
      body: json.encode(
        {
          "gtin": gtin,
          "digitalLinkType": "tblProductSafetyInformation",
        },
      ),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Host": "gtrack.info",
      },
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Data Loaded Successfully');
      final Map<String, dynamic> body = json.decode(response.body);
      final responseData = body['digitalLinkData'];
      for (var i = 0; i < responseData.length; i++) {
        futureData.add(SafetyInfoModel.fromJson(responseData[i]));
      }
      return futureData;
    } else {
      return futureData;
    }
  }
}
