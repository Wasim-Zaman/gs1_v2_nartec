// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:hiring_task/res/common/common.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUrlLauncher {
  // Whatsapp
  // void openWhatsApp(String phoneNumber) async {
  //   String url = "https://wa.me/$phoneNumber";
  //   await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  // }

  static launchUrl(Uri uri) async {
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      Common.showToast('Something went wrong');
    }
  }

  static whatsapp() async {
    var contact = "+966507921171";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      Common.showToast('Whatsapp not installed');
    }
  }

  static call() async {
    var contact = "011-2182128";
    var androidUrl = "tel://$contact";
    var iosUrl = "tel://$contact";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      Common.showToast('Something went wrong');
    }
  }
}
