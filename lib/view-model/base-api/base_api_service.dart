import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiring_task/models/product_contents_list_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class BaseApiService {
  static ProductContentsListModel? myData;

  static Future<ProductContentsListModel> getData(BuildContext context,
      {String? gtin}) async {
    final http.Response response = await http.post(
      Uri.parse(URL.baseUrl),
      body: json.encode(
        {
          "gtin": gtin,
        },
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final responseData = body['gtinArr'];
      myData = ProductContentsListModel.fromJson(responseData);
      return myData!;
    }
    return myData!;
  }
}
