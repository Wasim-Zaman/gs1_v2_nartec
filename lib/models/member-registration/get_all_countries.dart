class GetAllCountriesModel {
  String? id;
  String? nameEn;
  String? nameAr;
  String? countryCode;
  String? countryShortName;
  int? status;
  String? createdAt;
  String? updatedAt;

  GetAllCountriesModel(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.countryCode,
      this.countryShortName,
      this.status,
      this.createdAt,
      this.updatedAt});

  GetAllCountriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    countryCode = json['country_code'];
    countryShortName = json['country_shortName'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    data['country_code'] = countryCode;
    data['country_shortName'] = countryShortName;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
