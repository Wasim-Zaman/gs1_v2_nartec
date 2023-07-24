class GetAllCitiesModel {
  String? name;
  int? id;

  GetAllCitiesModel({this.name, this.id});

  GetAllCitiesModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
