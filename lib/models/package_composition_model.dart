class PkgCmpModel {
  String? iD;
  String? logo;
  String? title;
  String? consumerProductVariant;
  String? packaging;
  String? material;
  String? recyclability;
  String? productOwner;
  String? linkType;
  String? gTIN;
  String? brandOwner;

  PkgCmpModel(
      {this.iD,
      this.logo,
      this.title,
      this.consumerProductVariant,
      this.packaging,
      this.material,
      this.recyclability,
      this.productOwner,
      this.linkType,
      this.gTIN,
      this.brandOwner});

  PkgCmpModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    logo = json['logo'];
    title = json['title'];
    consumerProductVariant = json['consumerProductVariant'];
    packaging = json['packaging'];
    material = json['material'];
    recyclability = json['recyclability'];
    productOwner = json['productOwner'];
    linkType = json['LinkType'];
    gTIN = json['GTIN'];
    brandOwner = json['brand_owner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['logo'] = logo;
    data['title'] = title;
    data['consumerProductVariant'] = consumerProductVariant;
    data['packaging'] = packaging;
    data['material'] = material;
    data['recyclability'] = recyclability;
    data['productOwner'] = productOwner;
    data['LinkType'] = linkType;
    data['GTIN'] = gTIN;
    data['brand_owner'] = brandOwner;
    return data;
  }
}
