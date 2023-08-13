import 'dart:io';

import 'package:hiring_task/res/common/common.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUrlLauncher {
  // Whatsapp
  // void openWhatsApp(String phoneNumber) async {
  //   String url = "https://wa.me/$phoneNumber";
  //   await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  // }
  static whatsapp() async {
    var contact = "+923005447070";
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
}
