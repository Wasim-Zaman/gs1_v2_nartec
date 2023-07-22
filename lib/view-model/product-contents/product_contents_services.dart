import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hiring_task/models/product_contents_list_model.dart';
import 'package:hiring_task/models/product_contents_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class ProductContentsServices {
  static Future<List<ProductContentsModel>> getFutureData(
      BuildContext context) async {
    List<ProductContentsModel> futureData = [];
    final ProductContentsListModel data =
        ModalRoute.of(context)!.settings.arguments as ProductContentsListModel;
    final response = await http.post(Uri.parse(URL.digitalLink),
        body: json.encode({
          "gtin": data.gtin,
          "digitalLinkType": "tblProductContents",
        }),
        headers: {
          "Content-Type": "application/json",
        });

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Data Loaded Successfully');
      final Map<String, dynamic> body = json.decode(response.body);
      final responseData = body['digitalLinkData'];
      for (var i = 0; i < responseData.length; i++) {
        futureData.add(ProductContentsModel.fromJson(responseData[i]));
      }
      return futureData;
    } else {
      return futureData;
    }
  }
}
