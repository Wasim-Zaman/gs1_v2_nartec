class GetAllStatesModel {
  String? id;
  String? name;
  int? countryId;
  String? createdAt;
  String? updatedAt;

  GetAllStatesModel(
      {this.id, this.name, this.countryId, this.createdAt, this.updatedAt});

  GetAllStatesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['country_id'] = countryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
