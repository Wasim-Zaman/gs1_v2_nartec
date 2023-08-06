import 'dart:convert';

import 'package:hiring_task/models/login-models/profile/subscription_model.dart';
import 'package:hiring_task/utils/url.dart';
import 'package:http/http.dart' as http;

class RenewalServices {
  static Future<void> proceedRenewal(String userId,
      {SubscritionModel? subscritionModel}) async {
    const String url = '${BaseUrl.gs1}/api/member/subscription/renew';
    final otherSubscription = subscritionModel!.otherSubscription;
    final products = otherSubscription?.map((e) => e.otherProduct).toList();
    products!.insert(0, subscritionModel.gtinSubscription?.gtin);
    final quotation = otherSubscription?.map((e) => e.quotation).toList();
    quotation!.insert(0, subscritionModel.gtinSubscription?.quotation);
    final otherProductId =
        otherSubscription?.map((e) => e.otherProdID).toList();

    final otherPrice = otherSubscription?.map((e) => e.otherprice).toList();
    final yearlyFee = [...otherPrice!];
    double? x =
        double.parse(subscritionModel.gtinSubscription!.gtinprice.toString());
    yearlyFee.insert(0, x.toString());

    final yearlyFeeMap = {};
    final productsMap = {};
    final regFeeMap = {};
    final quotationMap = {};
    final otherProductIdMap = {};
    final otherPriceMap = {};
    for (int i = 0; i < products.length; i++) {
      productsMap[i.toString()] = products[i];
    }
    for (int i = 0; i < otherProductId!.length + 1; i++) {
      regFeeMap[i.toString()] = 0;
    }
    for (int i = 0; i < quotation.length; i++) {
      quotationMap[i.toString()] = quotation[i];
    }
    for (int i = 0; i < otherProductId.length; i++) {
      otherProductIdMap[i.toString()] = otherProductId[i];
    }
    for (int i = 0; i < otherPrice.length; i++) {
      otherPriceMap[i.toString()] = otherPrice[i];
    }
    for (int i = 0; i < yearlyFee.length; i++) {
      yearlyFeeMap[i.toString()] = yearlyFee[i];
    }

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Host': BaseUrl.host,
      },
      body: jsonEncode(
        {
          "payment_type": "bank_transfer",
          "product": productsMap,
          "registration_fee": regFeeMap,
          "user_id": userId,
          "renewGtinID": subscritionModel.gtinSubscription?.renewGtinID,
          "request_type": "renew",
          "quotation": quotationMap,
          "product_type": List.generate(products.length, (index) {
            if (index == 0) {
              return 'gtin';
            } else {
              return 'other';
            }
          }),
          "gtinprice": subscritionModel.gtinSubscription?.gtinprice,
          "total_no_of_barcodes":
              subscritionModel.gtinSubscription?.totalNoOfBarcodes,
          "yearly_fee": yearlyFeeMap,
          "otherProdID": otherProductIdMap,
          "otherprice": otherPriceMap,
        },
      ),
    );

    if (response.statusCode == 200) {
    } else {
      print("status code ${response.body}***&*&*&*&*&*&*&*W");
      throw Exception('Renewal Failed');
    }
  }
}
