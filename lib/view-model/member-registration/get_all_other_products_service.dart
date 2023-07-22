import 'dart:convert';

import 'package:hiring_task/models/member-registration/other_products_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class GetAllOtherProductsService {
  static List<OtherProductsModel> futureData = [];
  static Future<List<OtherProductsModel>> getList() async {
    const String url = '${BaseUrl.gs1WithPort}/api/GetAllOtherProduct';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body) as List;
      for (var element in responseBody) {
        futureData.add(OtherProductsModel.fromJson(element));
      }
      return futureData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
