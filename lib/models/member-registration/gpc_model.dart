class GPCModel {
  String? gpcCode;
  String? gpcTitle;

  GPCModel({this.gpcCode, this.gpcTitle});

  GPCModel.fromJson(Map<String, dynamic> json) {
    gpcCode = json['gpc_code'];
    gpcTitle = json['gpc_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gpc_code'] = gpcCode;
    data['gpc_title'] = gpcTitle;
    return data;
  }
}
