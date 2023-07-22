import 'package:flutter/foundation.dart';

class DashboardModel with ChangeNotifier {
  String? message;
  MemberData? memberData;

  DashboardModel({this.message, this.memberData});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    memberData = json['memberData'] != null
        ? MemberData.fromJson(json['memberData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (memberData != null) {
      data['memberData'] = memberData!.toJson();
    }
    return data;
  }
}

class MemberData {
  User? user;
  MemberCategory? memberCategory;
  String? gtinRange;
  int? issuedGTIN;
  int? remainingGTIN;
  int? glnTotalBarcode;
  int? issuedGLN;
  int? ssccTotalBarcode;
  int? issuedSSCC;

  MemberData(
      {this.user,
      this.memberCategory,
      this.gtinRange,
      this.issuedGTIN,
      this.remainingGTIN,
      this.glnTotalBarcode,
      this.issuedGLN,
      this.ssccTotalBarcode,
      this.issuedSSCC});

  MemberData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    memberCategory = json['memberCategory'] != null
        ? MemberCategory.fromJson(json['memberCategory'])
        : null;
    gtinRange = json['gtinRange'];
    issuedGTIN = json['issuedGTIN'];
    remainingGTIN = json['remainingGTIN'];
    glnTotalBarcode = json['glnTotalBarcode'];
    issuedGLN = json['issuedGLN'];
    ssccTotalBarcode = json['ssccTotalBarcode'];
    issuedSSCC = json['issuedSSCC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (memberCategory != null) {
      data['memberCategory'] = memberCategory!.toJson();
    }
    data['gtinRange'] = gtinRange;
    data['issuedGTIN'] = issuedGTIN;
    data['remainingGTIN'] = remainingGTIN;
    data['glnTotalBarcode'] = glnTotalBarcode;
    data['issuedGLN'] = issuedGLN;
    data['ssccTotalBarcode'] = ssccTotalBarcode;
    data['issuedSSCC'] = issuedSSCC;
    return data;
  }
}

class User {
  int? id;
  String? companyID;
  String? gcpGLNID;
  String? gcpExpiry;

  User({this.id, this.companyID, this.gcpGLNID, this.gcpExpiry});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyID = json['companyID'];
    gcpGLNID = json['gcpGLNID'];
    gcpExpiry = json['gcp_expiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['companyID'] = companyID;
    data['gcpGLNID'] = gcpGLNID;
    data['gcp_expiry'] = gcpExpiry;
    return data;
  }
}

class MemberCategory {
  String? memberCategoryDescription;
  String? totalNoOfBarcodes;

  MemberCategory({this.memberCategoryDescription, this.totalNoOfBarcodes});

  MemberCategory.fromJson(Map<String, dynamic> json) {
    memberCategoryDescription = json['member_category_description'];
    totalNoOfBarcodes = json['total_no_of_barcodes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['member_category_description'] = memberCategoryDescription;
    data['total_no_of_barcodes'] = totalNoOfBarcodes;
    return data;
  }
}
