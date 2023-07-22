import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiring_task/models/package_composition_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class PkgCompServices {
  static Future<PkgCmpModel> getFutureData(BuildContext context, String gtin,
      {String? id}) async {
    final response = await http.post(Uri.parse(URL.digitalLink),
        body: json.encode({
          "gtin": gtin,
          "digitalLinkType": "tblProductSafetyInformation",
          "ID": id,
        }),
        headers: {
          "Content-Type": "application/json",
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final responseData = body['digitalLinkData'];
      return (PkgCmpModel.fromJson(responseData));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
