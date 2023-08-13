// ignore_for_file: file_names

class IngredientsModel {
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
  String? unitPrice;
  String? ingredients;
  String? allergenInfo;
  String? calories;
  String? sugar;
  String? salt;
  String? fat;

  IngredientsModel({
    this.iD,
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
    this.unitPrice,
    this.ingredients,
    this.allergenInfo,
    this.calories,
    this.sugar,
    this.salt,
    this.fat,
  });

  IngredientsModel.fromJson(Map<String, dynamic> json) {
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
    ingredients = json['ingredients'];
    allergenInfo = json['allergen_info'];
    calories = json['calories'];
    sugar = json['sugar'];
    salt = json['salt'];
    fat = json['fat'];
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
    data['ingredients'] = ingredients;
    data['allergen_info'] = allergenInfo;
    data['calories'] = calories;
    data['sugar'] = sugar;
    data['salt'] = salt;
    data['fat'] = fat;
    return data;
  }
}
