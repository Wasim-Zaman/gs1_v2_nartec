class SubscritionModel {
  GtinSubscription? gtinSubscription;
  List<OtherSubscription>? otherSubscription;

  SubscritionModel({this.gtinSubscription, this.otherSubscription});

  SubscritionModel.fromJson(Map<String, dynamic> json) {
    gtinSubscription = json['gtin_subscription'] != null
        ? new GtinSubscription.fromJson(json['gtin_subscription'])
        : null;
    if (json['other_subscription'] != null) {
      otherSubscription = <OtherSubscription>[];
      json['other_subscription'].forEach((v) {
        otherSubscription!.add(new OtherSubscription.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gtinSubscription != null) {
      data['gtin_subscription'] = this.gtinSubscription!.toJson();
    }
    if (this.otherSubscription != null) {
      data['other_subscription'] =
          this.otherSubscription!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['renewGtinID'] = this.renewGtinID;
    data['gtin'] = this.gtin;
    data['quotation'] = this.quotation;
    data['total_no_of_barcodes'] = this.totalNoOfBarcodes;
    data['gtinprice'] = this.gtinprice;
    data['yearly_fee'] = this.yearlyFee;
    data['register_date'] = this.registerDate;
    data['expiry'] = this.expiry;
    return data;
  }
}

class OtherSubscription {
  int? otherProdID;
  String? otherProduct;
  int? otherprice;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otherProdID'] = this.otherProdID;
    data['other_product'] = this.otherProduct;
    data['otherprice'] = this.otherprice;
    data['register_date'] = this.registerDate;
    data['expiry'] = this.expiry;
    data['quotation'] = this.quotation;
    return data;
  }
}
