class GetAllCitiesModel {
  String? id;
  String? name;
  int? stateId;
  String? createdAt;
  String? updatedAt;

  GetAllCitiesModel(
      {this.id, this.name, this.stateId, this.createdAt, this.updatedAt});

  GetAllCitiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stateId = json['state_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['state_id'] = stateId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
