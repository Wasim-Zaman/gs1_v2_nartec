import 'dart:convert';

import 'package:hiring_task/models/member-registration/documents_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class DocumentServices {
  static const String url = ("${BaseUrl.gs1}/api/documents");

  static Future<List<DocumentsModel>> getDocuments() {
    return http.get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200) {
        print('200');
        final responseBody = json.decode(response.body) as List;
        final List<DocumentsModel> documents = responseBody
            .map((document) => DocumentsModel.fromJson(document))
            .toList();
        return documents;
      } else {
        throw Exception('Failed to load documents');
      }
    });
  }
}
