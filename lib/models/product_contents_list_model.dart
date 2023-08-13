class ProductContentsListModel {
  String? gtin;
  String? companyName;
  String? licenceKey;
  String? website;
  String? address;
  String? licenceType;
  String? gpcCategoryCode;
  String? brandName;
  String? productDescription;
  String? productImageUrl;
  String? unitCode;
  String? unitValue;
  String? countryOfSaleCode;
  String? productName;
  String? gcpGLNID;
  String? status;

  ProductContentsListModel(
      {this.gtin,
      this.companyName,
      this.licenceKey,
      this.website,
      this.address,
      this.licenceType,
      this.gpcCategoryCode,
      this.brandName,
      this.productDescription,
      this.productImageUrl,
      this.unitCode,
      this.unitValue,
      this.countryOfSaleCode,
      this.productName,
      this.gcpGLNID,
      this.status});

  ProductContentsListModel.fromJson(Map<String, dynamic> json) {
    gtin = json['gtin'];
    companyName = json['companyName'];
    licenceKey = json['licenceKey'];
    website = json['website'];
    address = json['address'];
    licenceType = json['licenceType'];
    gpcCategoryCode = json['gpcCategoryCode'];
    brandName = json['brandName'];
    productDescription = json['productDescription'];
    productImageUrl = json['productImageUrl'];
    unitCode = json['unitCode'];
    unitValue = json['unitValue'];
    countryOfSaleCode = json['countryOfSaleCode'];
    productName = json['productName'];
    gcpGLNID = json['gcpGLNID'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gtin'] = gtin;
    data['companyName'] = companyName;
    data['licenceKey'] = licenceKey;
    data['website'] = website;
    data['address'] = address;
    data['licenceType'] = licenceType;
    data['gpcCategoryCode'] = gpcCategoryCode;
    data['brandName'] = brandName;
    data['productDescription'] = productDescription;
    data['productImageUrl'] = productImageUrl;
    data['unitCode'] = unitCode;
    data['unitValue'] = unitValue;
    data['countryOfSaleCode'] = countryOfSaleCode;
    data['productName'] = productName;
    data['gcpGLNID'] = gcpGLNID;
    data['status'] = status;
    return data;
  }
}
