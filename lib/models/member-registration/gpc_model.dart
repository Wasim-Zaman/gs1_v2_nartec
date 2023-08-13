class GPCModel {
  String? value;
  String? codeTitle;
  String? gpcCode;

  GPCModel({this.value, this.codeTitle, this.gpcCode});

  GPCModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    codeTitle = json['codeTitle'];
    gpcCode = json['gpcCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['codeTitle'] = codeTitle;
    data['gpcCode'] = gpcCode;
    return data;
  }
}
