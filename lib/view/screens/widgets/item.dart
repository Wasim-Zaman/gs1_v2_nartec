import 'package:flutter/material.dart';

class Item {
  Item({
    required this.headers,
    required this.body,
    required this.isExpanded,
  });
  String headers;
  Widget body;
  bool isExpanded;
}
