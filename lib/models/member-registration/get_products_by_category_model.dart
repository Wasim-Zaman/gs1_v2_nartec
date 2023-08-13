class GetProductsByCategoryModel {
  List<GtinProducts>? gtinProducts;
  List<OtherProducts>? otherProducts;

  GetProductsByCategoryModel({this.gtinProducts, this.otherProducts});

  GetProductsByCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['gtinProducts'] != null) {
      gtinProducts = <GtinProducts>[];
      json['gtinProducts'].forEach((v) {
        gtinProducts!.add(GtinProducts.fromJson(v));
      });
    }
    if (json['otherProducts'] != null) {
      otherProducts = <OtherProducts>[];
      json['otherProducts'].forEach((v) {
        otherProducts!.add(OtherProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (gtinProducts != null) {
      data['gtinProducts'] = gtinProducts!.map((v) => v.toJson()).toList();
    }
    if (otherProducts != null) {
      data['otherProducts'] = otherProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GtinProducts {
  int? productID;
  String? productName;
  String? totalBarcodes;
  String? registrationFee;
  String? yearlyFee;
  String? quotation;
  String? allowOtherProducts;

  GtinProducts(
      {this.productID,
      this.productName,
      this.totalBarcodes,
      this.registrationFee,
      this.yearlyFee,
      this.quotation,
      this.allowOtherProducts});

  GtinProducts.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    productName = json['productName'];
    totalBarcodes = json['total_barcodes'];
    registrationFee = json['registrationFee'];
    yearlyFee = json['yearlyFee'];
    quotation = json['quotation'];
    allowOtherProducts = json['allow_otherProducts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productID'] = productID;
    data['productName'] = productName;
    data['total_barcodes'] = totalBarcodes;
    data['registrationFee'] = registrationFee;
    data['yearlyFee'] = yearlyFee;
    data['quotation'] = quotation;
    data['allow_otherProducts'] = allowOtherProducts;
    return data;
  }
}

class OtherProducts {
  int? otherProdID;
  String? productName;
  int? totalBarcodes;
  String? yearlyFee;

  OtherProducts(
      {this.otherProdID, this.productName, this.totalBarcodes, this.yearlyFee});

  OtherProducts.fromJson(Map<String, dynamic> json) {
    otherProdID = json['otherProdID'];
    productName = json['productName'];
    totalBarcodes = json['total_barcodes'];
    yearlyFee = json['yearlyFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otherProdID'] = otherProdID;
    data['productName'] = productName;
    data['total_barcodes'] = totalBarcodes;
    data['yearlyFee'] = yearlyFee;
    return data;
  }
}
