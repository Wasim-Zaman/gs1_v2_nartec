import 'dart:convert';

import 'package:hiring_task/models/member-registration/get_products_by_category_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class GetProductsByCategoryServices {
  static Future<GetProductsByCategoryModel> getProductsByCategory(
      String category) async {
    GetProductsByCategoryModel getProductsByCategoryModel =
        GetProductsByCategoryModel();
    String cat = '';

    if (category == 'Non-Medical Category') {
      cat = 'non_med_category';
    } else {
      cat = 'med_category';
    }
    try {
      final url = Uri.parse('${BaseUrl.gs1}/api/get/registration/products');
      final response = await http.post(url,
          body: json.encode({
            "gtin_category": cat,
          }),
          headers: {
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        getProductsByCategoryModel =
            GetProductsByCategoryModel.fromJson(responseData);
        return getProductsByCategoryModel;
      } else {
        return getProductsByCategoryModel;
      }
    } catch (e) {
      return getProductsByCategoryModel;
    }
  }
}
