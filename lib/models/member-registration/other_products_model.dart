class OtherProductsModel {
  String? id;
  String? productName;
  int? totalNoOfBarcodes;
  int? productSubscriptionFee;
  String? code;
  int? status;
  String? createdAt;
  String? updatedAt;

  OtherProductsModel(
      {this.id,
      this.productName,
      this.totalNoOfBarcodes,
      this.productSubscriptionFee,
      this.code,
      this.status,
      this.createdAt,
      this.updatedAt});

  OtherProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    totalNoOfBarcodes = json['total_no_of_barcodes'];
    productSubscriptionFee = json['product_subscription_fee'];
    code = json['code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_name'] = productName;
    data['total_no_of_barcodes'] = totalNoOfBarcodes;
    data['product_subscription_fee'] = productSubscriptionFee;
    data['code'] = code;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
