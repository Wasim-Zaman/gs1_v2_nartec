class SSCCModel {
  String? ssccType;
  String? gcpGLNID;
  String? sSCCBarcodeNumber;

  SSCCModel({this.ssccType, this.gcpGLNID, this.sSCCBarcodeNumber});

  SSCCModel.fromJson(Map<String, dynamic> json) {
    ssccType = json['sscc_type'];
    gcpGLNID = json['gcpGLNID'];
    sSCCBarcodeNumber = json['SSCCBarcodeNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sscc_type'] = ssccType;
    data['gcpGLNID'] = gcpGLNID;
    data['SSCCBarcodeNumber'] = sSCCBarcodeNumber;
    return data;
  }
}
