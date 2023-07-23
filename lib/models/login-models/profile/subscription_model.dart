class SubscritionModel {
  GtinSubscription? gtinSubscription;
  List<OtherSubscription>? otherSubscription;

  SubscritionModel({this.gtinSubscription, this.otherSubscription});

  SubscritionModel.fromJson(Map<String, dynamic> json) {
    gtinSubscription = json['gtin_subscription'] != null
        ? GtinSubscription.fromJson(json['gtin_subscription'])
        : null;
    if (json['other_subscription'] != null) {
      otherSubscription = <OtherSubscription>[];
      json['other_subscription'].forEach((v) {
        otherSubscription!.add(OtherSubscription.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (gtinSubscription != null) {
      data['gtin_subscription'] = gtinSubscription!.toJson();
    }
    if (otherSubscription != null) {
      data['other_subscription'] =
          otherSubscription!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GtinSubscription {
  int? renewGtinID;
  String? gtin;
  String? quotation;
  String? totalNoOfBarcodes;
  String? gtinprice;
  String? yearlyFee;
  String? registerDate;
  String? expiry;

  GtinSubscription(
      {this.renewGtinID,
      this.gtin,
      this.quotation,
      this.totalNoOfBarcodes,
      this.gtinprice,
      this.yearlyFee,
      this.registerDate,
      this.expiry});

  GtinSubscription.fromJson(Map<String, dynamic> json) {
    renewGtinID = json['renewGtinID'];
    gtin = json['gtin'];
    quotation = json['quotation'];
    totalNoOfBarcodes = json['total_no_of_barcodes'];
    gtinprice = json['gtinprice'];
    yearlyFee = json['yearly_fee'];
    registerDate = json['register_date'];
    expiry = json['expiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['renewGtinID'] = renewGtinID;
    data['gtin'] = gtin;
    data['quotation'] = quotation;
    data['total_no_of_barcodes'] = totalNoOfBarcodes;
    data['gtinprice'] = gtinprice;
    data['yearly_fee'] = yearlyFee;
    data['register_date'] = registerDate;
    data['expiry'] = expiry;
    return data;
  }
}

class OtherSubscription {
  num? otherProdID;
  String? otherProduct;
  String? otherprice;
  String? registerDate;
  String? expiry;
  String? quotation;

  OtherSubscription(
      {this.otherProdID,
      this.otherProduct,
      this.otherprice,
      this.registerDate,
      this.expiry,
      this.quotation});

  OtherSubscription.fromJson(Map<String, dynamic> json) {
    otherProdID = json['otherProdID'];
    otherProduct = json['other_product'];
    otherprice = json['otherprice'];
    registerDate = json['register_date'];
    expiry = json['expiry'];
    quotation = json['quotation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otherProdID'] = otherProdID;
    data['other_product'] = otherProduct;
    data['otherprice'] = otherprice;
    data['register_date'] = registerDate;
    data['expiry'] = expiry;
    data['quotation'] = quotation;
    return data;
  }
}
