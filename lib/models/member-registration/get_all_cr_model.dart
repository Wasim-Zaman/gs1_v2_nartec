class GetAllCrActivitiesModel {
  String? cr;
  String? activity;

  GetAllCrActivitiesModel({this.cr, this.activity});

  GetAllCrActivitiesModel.fromJson(Map<String, dynamic> json) {
    cr = json['cr'];
    activity = json['activity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cr'] = this.cr;
    data['activity'] = this.activity;
    return data;
  }
}
