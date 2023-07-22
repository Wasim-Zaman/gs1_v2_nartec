import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String gtin;
  final String productImageUrl;
  final String productDescription;
  final String productName;

  Product({
    required this.gtin,
    required this.productImageUrl,
    required this.productDescription,
    required this.productName,
  });
}
