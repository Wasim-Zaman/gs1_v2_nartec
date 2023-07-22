import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hiring_task/models/ingredientsModel.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class IngredientsServices {
  static Future<List<IngredientsModel>> getFutureData(BuildContext context,
      {String? id, String? gtin}) async {
    final List<IngredientsModel> futureData = [];
    final response = await http.post(
      Uri.parse(URL.digitalLink),
      body: json.encode(
        {
          "gtin": gtin,
          "digitalLinkType": "tblProductContents",
        },
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Data loaded",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      final Map<String, dynamic> body = json.decode(response.body);
      final responseData = body['digitalLinkData'] as List;
      for (var element in responseData) {
        futureData.add(IngredientsModel.fromJson(element));
      }
      return futureData;
    } else {
      Fluttertoast.showToast(
        msg: "Failed to load data",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      throw Exception('Failed to load data');
    }
  }
}
