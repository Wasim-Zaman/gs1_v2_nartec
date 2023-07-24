class GetCountriesModel {
  int? id;
  String? nameEn;
  String? countryShortName;

  GetCountriesModel({this.id, this.nameEn, this.countryShortName});

  GetCountriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    countryShortName = json['country_shortName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_en'] = nameEn;
    data['country_shortName'] = countryShortName;
    return data;
  }
}
