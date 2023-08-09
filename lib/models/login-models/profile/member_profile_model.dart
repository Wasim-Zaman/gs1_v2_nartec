class MemberProfileModel {
  MemberProfile? memberProfile;
  MemberDetails? memberDetails;

  MemberProfileModel({this.memberProfile, this.memberDetails});

  MemberProfileModel.fromJson(Map<String, dynamic> json) {
    memberProfile = json['memberProfile'] != null
        ? MemberProfile.fromJson(json['memberProfile'])
        : null;
    memberDetails = json['memberDetails'] != null
        ? MemberDetails.fromJson(json['memberDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (memberProfile != null) {
      data['memberProfile'] = memberProfile!.toJson();
    }
    if (memberDetails != null) {
      data['memberDetails'] = memberDetails!.toJson();
    }
    return data;
  }
}

class MemberProfile {
  String? image;
  String? imagePath;
  String? companyNameEng;
  String? companyNameArabic;
  String? mobile;
  String? mblExtension;
  Address? address;
  String? address1;
  String? additionalNumber;
  String? otherLandline;
  String? district;
  String? website;
  String? noOfStaff;
  String? buildingNo;
  String? unitNumber;
  String? qrCorde;
  String? companyID;
  String? addressImage;

  MemberProfile(
      {this.image,
      this.imagePath,
      this.companyNameEng,
      this.companyNameArabic,
      this.mobile,
      this.mblExtension,
      this.address,
      this.address1,
      this.additionalNumber,
      this.otherLandline,
      this.district,
      this.website,
      this.noOfStaff,
      this.buildingNo,
      this.unitNumber,
      this.qrCorde,
      this.companyID,
      this.addressImage});

  MemberProfile.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    imagePath = json['image_path'];
    companyNameEng = json['company_name_eng'];
    companyNameArabic = json['company_name_arabic'];
    mobile = json['mobile'];
    mblExtension = json['mbl_extension'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    address1 = json['address1'];
    additionalNumber = json['additional_number'];
    otherLandline = json['other_landline'];
    district = json['district'];
    website = json['website'];
    noOfStaff = json['no_of_staff'];
    buildingNo = json['building_no'];
    unitNumber = json['unit_number'];
    qrCorde = json['qr_corde'];
    companyID = json['companyID'];
    addressImage = json['address_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['image_path'] = imagePath;
    data['company_name_eng'] = companyNameEng;
    data['company_name_arabic'] = companyNameArabic;
    data['mobile'] = mobile;
    data['mbl_extension'] = mblExtension;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['address1'] = address1;
    data['additional_number'] = additionalNumber;
    data['other_landline'] = otherLandline;
    data['district'] = district;
    data['website'] = website;
    data['no_of_staff'] = noOfStaff;
    data['building_no'] = buildingNo;
    data['unit_number'] = unitNumber;
    data['qr_corde'] = qrCorde;
    data['companyID'] = companyID;
    data['address_image'] = addressImage;
    return data;
  }
}

class Address {
  String? countryName;
  String? countryShortName;
  String? cityName;
  String? stateName;
  String? zip;
  String? address;

  Address(
      {this.countryName,
      this.countryShortName,
      this.cityName,
      this.stateName,
      this.zip,
      this.address});

  Address.fromJson(Map<String, dynamic> json) {
    countryName = json['countryName'];
    countryShortName = json['country_shortName'];
    cityName = json['cityName'];
    stateName = json['stateName'];
    zip = json['zip'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countryName'] = countryName;
    data['country_shortName'] = countryShortName;
    data['cityName'] = cityName;
    data['stateName'] = stateName;
    data['zip'] = zip;
    data['address'] = address;
    return data;
  }
}

class MemberDetails {
  String? crNumber;
  String? crActivity;
  String? crDocument;
  String? documentNumber;
  String? companyGcp;
  String? contactPerson;
  String? companyLandLine;
  String? gpc;
  String? memberCategory;
  List<String>? products;

  MemberDetails(
      {this.crNumber,
      this.crActivity,
      this.crDocument,
      this.documentNumber,
      this.companyGcp,
      this.contactPerson,
      this.companyLandLine,
      this.gpc,
      this.memberCategory,
      this.products});

  MemberDetails.fromJson(Map<String, dynamic> json) {
    crNumber = json['cr_number'];
    crActivity = json['cr_activity'];
    crDocument = json['cr_document'];
    documentNumber = json['document_number'];
    companyGcp = json['company_gcp'];
    contactPerson = json['contactPerson'];
    companyLandLine = json['companyLandLine'];
    gpc = json['gpc'];
    memberCategory = json['member_category'];
    products = json['products'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cr_number'] = crNumber;
    data['cr_activity'] = crActivity;
    data['cr_document'] = crDocument;
    data['document_number'] = documentNumber;
    data['company_gcp'] = companyGcp;
    data['contactPerson'] = contactPerson;
    data['companyLandLine'] = companyLandLine;
    data['gpc'] = gpc;
    data['member_category'] = memberCategory;
    data['products'] = products;
    return data;
  }
}
