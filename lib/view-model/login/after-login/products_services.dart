import 'dart:convert';

import 'package:hiring_task/models/login-models/products_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class ProductsServices {
  static ProductsModel? products;
  static Future<ProductsModel> getProducts(int userId) async {
    const baseUrl = '${BaseUrl.gs1}/api/member/products';
    final uri = Uri.parse(baseUrl);
    try {
      final response = await http.post(
        uri,
        body: json.encode(
          {
            'user_id': userId.toString(),
          },
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Host': BaseUrl.host,
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        products = ProductsModel.fromJson(data);
        return products ?? ProductsModel();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      rethrow;
    }
  }
}
