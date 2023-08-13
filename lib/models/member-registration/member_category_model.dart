class MemberCategoryModel {
  String? id;
  String? memberCategoryDescription;
  int? totalNoOfBarcodes;
  int? memberRegistrationFee;
  int? gtinYearlySubscriptionFee;
  String? type;
  int? status;
  String? gcpStartRange;
  String? quotation;
  String? allowOtherProducts;
  String? gcpType;
  String? gtinOrder;
  String? createdAt;
  String? updatedAt;
  String? memberCategoryDescriptionAr;

  MemberCategoryModel(
      {this.id,
      this.memberCategoryDescription,
      this.totalNoOfBarcodes,
      this.memberRegistrationFee,
      this.gtinYearlySubscriptionFee,
      this.type,
      this.status,
      this.gcpStartRange,
      this.quotation,
      this.allowOtherProducts,
      this.gcpType,
      this.gtinOrder,
      this.createdAt,
      this.updatedAt,
      this.memberCategoryDescriptionAr});

  MemberCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberCategoryDescription = json['member_category_description'];
    totalNoOfBarcodes = json['total_no_of_barcodes'];
    memberRegistrationFee = json['member_registration_fee'];
    gtinYearlySubscriptionFee = json['gtin_yearly_subscription_fee'];
    type = json['type'];
    status = json['status'];
    gcpStartRange = json['gcp_start_range'];
    quotation = json['quotation'];
    allowOtherProducts = json['allow_otherProducts'];
    gcpType = json['gcp_type'];
    gtinOrder = json['gtin_order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    memberCategoryDescriptionAr = json['member_category_description_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['member_category_description'] = memberCategoryDescription;
    data['total_no_of_barcodes'] = totalNoOfBarcodes;
    data['member_registration_fee'] = memberRegistrationFee;
    data['gtin_yearly_subscription_fee'] = gtinYearlySubscriptionFee;
    data['type'] = type;
    data['status'] = status;
    data['gcp_start_range'] = gcpStartRange;
    data['quotation'] = quotation;
    data['allow_otherProducts'] = allowOtherProducts;
    data['gcp_type'] = gcpType;
    data['gtin_order'] = gtinOrder;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['member_category_description_ar'] = memberCategoryDescriptionAr;
    return data;
  }
}
