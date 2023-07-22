class ProductContentsModel {
  String? iD;
  String? productAllergenInformation;
  String? productNutrientsInformation;
  String? gTIN;
  String? linkType;
  String? batch;
  String? expiry;
  String? serial;
  String? manufacturingDate;
  String? bestBeforeDate;
  String? gLNIDFrom;
  num? unitPrice;

  ProductContentsModel(
      {this.iD,
      this.productAllergenInformation,
      this.productNutrientsInformation,
      this.gTIN,
      this.linkType,
      this.batch,
      this.expiry,
      this.serial,
      this.manufacturingDate,
      this.bestBeforeDate,
      this.gLNIDFrom,
      this.unitPrice});

  ProductContentsModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    productAllergenInformation = json['ProductAllergenInformation'];
    productNutrientsInformation = json['ProductNutrientsInformation'];
    gTIN = json['GTIN'];
    linkType = json['LinkType'];
    batch = json['Batch'];
    expiry = json['Expiry'];
    serial = json['Serial'];
    manufacturingDate = json['ManufacturingDate'];
    bestBeforeDate = json['bestBeforeDate'];
    gLNIDFrom = json['GLNIDFrom'];
    unitPrice = json['unitPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['ProductAllergenInformation'] = productAllergenInformation;
    data['ProductNutrientsInformation'] = productNutrientsInformation;
    data['GTIN'] = gTIN;
    data['LinkType'] = linkType;
    data['Batch'] = batch;
    data['Expiry'] = expiry;
    data['Serial'] = serial;
    data['ManufacturingDate'] = manufacturingDate;
    data['bestBeforeDate'] = bestBeforeDate;
    data['GLNIDFrom'] = gLNIDFrom;
    data['unitPrice'] = unitPrice;
    return data;
  }
}
