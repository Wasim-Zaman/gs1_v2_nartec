import 'package:flutter/material.dart';
import 'package:hiring_task/providers/gtin.dart';
import 'package:hiring_task/view/screens/member-screens/get_barcode_screen.dart';
import 'package:hiring_task/view/screens/product-tracking/gtin_reporter_screen.dart';
import 'package:hiring_task/view/screens/qr_code_scanning_screen.dart';
import 'package:hiring_task/view/screens/regulatory_affairs_screen.dart';
import 'package:hiring_task/view/screens/retail_information_screen.dart';
import 'package:hiring_task/view/screens/retailor_shopper_screen.dart';
import 'package:hiring_task/view/screens/verified-by-gs1/verify_by_gs1_screen.dart';
import 'package:provider/provider.dart';

class HomeServices {
  static void productContentsClick(BuildContext context) {
    // Navigate to new page
    Provider.of<GTIN>(context, listen: false).gtinNumber == null
        ? Navigator.of(context)
            .pushNamed(QRCodeScanningScreen.routeName, arguments: {
            "icon": "product-contents",
          })
        : Navigator.of(context).pushNamed(
            RetailorShopperScreen.routeName,
            arguments: Provider.of<GTIN>(context, listen: false).gtinNumber,
          );
  }

  static void retailInformationClick(BuildContext context) {
    Provider.of<GTIN>(context, listen: false).gtinNumber == null
        ? Navigator.of(context)
            .pushNamed(QRCodeScanningScreen.routeName, arguments: {
            "icon": "retail-information",
          })
        : Navigator.of(context).pushNamed(
            RetailInformationScreen.routeName,
            arguments: Provider.of<GTIN>(context, listen: false).gtinNumber,
          );
  }

  static void regulatoryAffairsClick(BuildContext context) {
    Provider.of<GTIN>(context, listen: false).gtinNumber == null
        ? Navigator.of(context)
            .pushNamed(QRCodeScanningScreen.routeName, arguments: {
            "icon": "regulatory-affairs",
          })
        : Navigator.of(context).pushNamed(
            RegulatoryAffairsScreen.routeName,
            arguments: Provider.of<GTIN>(context, listen: false).gtinNumber,
          );
  }

  static void verifiedByGS1Click(BuildContext context) {
    Provider.of<GTIN>(context, listen: false).gtinNumber == null
        ? Navigator.of(context)
            .pushNamed(QRCodeScanningScreen.routeName, arguments: {
            "icon": "verified-by-gs1",
          })
        : Navigator.of(context).pushNamed(
            VerifyByGS1Screen.routeName,
            arguments: Provider.of<GTIN>(context, listen: false).gtinNumber,
          );
  }

  static void gtinReporterClick(BuildContext context) {
    Provider.of<GTIN>(context, listen: false).gtinNumber == null
        ? Navigator.of(context)
            .pushNamed(QRCodeScanningScreen.routeName, arguments: {
            "icon": "gtin-reporter",
          })
        : Navigator.of(context).pushNamed(
            GtinReporterScreen.routeName,
            arguments: Provider.of<GTIN>(context, listen: false).gtinNumber,
          );
  }

  static getBarCode(BuildContext context) {
    Navigator.of(context).pushNamed(GetBarcodeScreen.routeName);
  }
}
