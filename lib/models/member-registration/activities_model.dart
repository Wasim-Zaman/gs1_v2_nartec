class ActivitiesModel {
  String? id;
  String? cr;
  String? activity;
  int? status;
  String? createdAt;
  String? updatedAt;

  ActivitiesModel(
      {this.id,
      this.cr,
      this.activity,
      this.status,
      this.createdAt,
      this.updatedAt});

  ActivitiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cr = json['cr'];
    activity = json['activity'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cr'] = this.cr;
    data['activity'] = this.activity;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
