class PromotionalOffersModel {
  String? iD;
  String? promotionalOffers;
  String? linkType;
  String? lang;
  String? targetURL;
  String? gTIN;
  String? expiryDate;

  PromotionalOffersModel(
      {this.iD,
      this.promotionalOffers,
      this.linkType,
      this.lang,
      this.targetURL,
      this.gTIN,
      this.expiryDate});

  PromotionalOffersModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    promotionalOffers = json['PromotionalOffers'];
    linkType = json['LinkType'];
    lang = json['Lang'];
    targetURL = json['TargetURL'];
    gTIN = json['GTIN'];
    expiryDate = json['ExpiryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['PromotionalOffers'] = promotionalOffers;
    data['LinkType'] = linkType;
    data['Lang'] = lang;
    data['TargetURL'] = targetURL;
    data['GTIN'] = gTIN;
    data['ExpiryDate'] = expiryDate;
    return data;
  }
}
