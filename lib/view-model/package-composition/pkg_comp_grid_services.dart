import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiring_task/models/package_composition_model.dart';
import 'package:hiring_task/utils/url.dart';

import 'package:http/http.dart' as http;

class PkgCompGridServices {
  static Future<List<PkgCmpModel>> getData(BuildContext context,
      {String? gtin}) async {
    final List<PkgCmpModel> futureData = [];
    final response = await http.post(Uri.parse(URL.digitalLink),
        body: json.encode({
          "gtin": gtin,
          "digitalLinkType": "tblPkgComposition",
        }),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Host": "gtrack.info",
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      final responseData = body['digitalLinkData'];
      for (var i = 0; i < responseData.length; i++) {
        futureData.add(PkgCmpModel.fromJson(responseData[i]));
      }
      return futureData;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
