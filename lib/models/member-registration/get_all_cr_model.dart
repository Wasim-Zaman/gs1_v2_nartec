class GetAllCrActivitiesModel {
  String? id;
  String? cr;
  String? activity;

  GetAllCrActivitiesModel({this.id, this.cr, this.activity});

  GetAllCrActivitiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cr = json['cr'];
    activity = json['activity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cr'] = cr;
    data['activity'] = activity;
    return data;
  }
}
