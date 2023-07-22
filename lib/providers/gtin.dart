import 'package:flutter/foundation.dart';

class GTIN with ChangeNotifier {
  String? _gtinNumber;
  String? get gtinNumber => _gtinNumber;
  set gtinNumber(String? value) {
    _gtinNumber = value;
    notifyListeners();
  }
}
