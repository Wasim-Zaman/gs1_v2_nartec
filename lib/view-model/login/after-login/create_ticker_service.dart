import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hiring_task/res/common/common.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class CreateTicketService {
  static Future<void> createTicket({
    String? userId,
    File? file,
    String? title,
    String? description,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${BaseUrl.gs1}/api/create/ticket"),
      );

      request.fields['title'] = title ?? "";
      request.fields['description'] = description ?? "";
      request.fields['user_id'] = userId ?? "";

      // Add image file to request
      var imageStream = http.ByteStream(file!.openRead());
      var imageLength = await file.length();
      var imageMultipartFile = http.MultipartFile(
          'document', imageStream, imageLength,
          filename: file.path);
      request.files.add(imageMultipartFile);

      print('sending....');

      // getting response
      try {
        final response = await request.send();

        if (response.statusCode == 200) {
          Common.showToast(
            "Query Added Successfully",
            backgroundColor: Colors.teal,
          );

          // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        } else {
          Common.showToast(
            "Something went wrong, please try again",
            backgroundColor: Colors.red,
          );
        }
      } catch (error) {
        Common.showToast(
          "Something went wrong, please try again",
          backgroundColor: Colors.red,
        );
        print("********** Error: $error");
      }
    } catch (error) {
      Common.showToast(
        "Something went wrong, please try again",
        backgroundColor: Colors.red,
      );
      print("********** Error: $error");
    }
  }
}
