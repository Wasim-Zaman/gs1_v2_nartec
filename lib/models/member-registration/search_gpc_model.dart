class SearchGPCModel {
  String? gpcCode;
  String? gpcTitle;

  SearchGPCModel({this.gpcCode, this.gpcTitle});

  SearchGPCModel.fromJson(Map<String, dynamic> json) {
    gpcCode = json['gpc_code'];
    gpcTitle = json['gpc_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gpc_code'] = gpcCode;
    data['gpc_title'] = gpcTitle;
    return data;
  }
}
