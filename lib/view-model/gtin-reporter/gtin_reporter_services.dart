import 'dart:io';

import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class GtinReporterServices {
  static Future<void> proceesGtin({
    String? reportBarcode,
    String? gtinComment,
    String? gtinReportAction,
    String? mobileNo,
    String? email,
    List<File>? reporterImages,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${BaseUrl.gs1}/api/gtin/report'),
      );

      request.fields['report_barcode'] = reportBarcode.toString();
      request.fields['gtin_comment'] = gtinComment.toString();
      request.fields['report_action'] = gtinReportAction.toString();
      request.fields['mobile_no'] = mobileNo.toString();
      request.fields['email'] = email.toString();

      for (var image in reporterImages!) {
        var imageStream = http.ByteStream(image.openRead());
        var imageLength = await image.length();
        var imageMultipartFile = http.MultipartFile(
          'reporter_images',
          imageStream,
          imageLength,
          filename: image.path,
        );
        request.files.add(imageMultipartFile);
      }

      var response = await request.send();
      if (response.statusCode == 200) {
      } else {
        throw Exception('Something went wrong, please try again later');
      }
    } catch (e) {
      rethrow;
    }
  }
}
