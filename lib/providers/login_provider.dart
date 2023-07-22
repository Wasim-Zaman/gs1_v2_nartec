import 'package:flutter/foundation.dart';

class LoginProvider with ChangeNotifier {
  String? _email;
  String? _password;
  String? _otp;
  String? _activity;
  List? _activities;

  String? get email => _email;
  String? get password => _password;
  String? get otp => _otp;
  String? get activity => _activity;
  List? get activities => _activities;

  void setEmail(String? email) {
    _email = email;
    notifyListeners();
  }

  void setActivities(List? activities) {
    _activities = activities;
    notifyListeners();
  }

  void setPassword(String? password) {
    _password = password;
    notifyListeners();
  }

  void setOtp(String? otp) {
    _otp = otp;
    notifyListeners();
  }

  void setActivity(String? activity) {
    _activity = activity;
    notifyListeners();
  }
}
