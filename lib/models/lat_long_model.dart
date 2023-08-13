class LatLongModel {
  String? itemRefNo;
  String? itemGPSOnGoLat;
  String? itemGPSOnGoLon;
  String? trxGLNIDTo;

  LatLongModel(
      {this.itemRefNo,
      this.itemGPSOnGoLat,
      this.itemGPSOnGoLon,
      this.trxGLNIDTo});

  LatLongModel.fromJson(Map<String, dynamic> json) {
    itemRefNo = json['ItemRefNo'];
    itemGPSOnGoLat = json['ItemGPSOnGoLat'];
    itemGPSOnGoLon = json['ItemGPSOnGoLon'];
    trxGLNIDTo = json['TrxGLNIDTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ItemRefNo'] = itemRefNo;
    data['ItemGPSOnGoLat'] = itemGPSOnGoLat;
    data['ItemGPSOnGoLon'] = itemGPSOnGoLon;
    data['TrxGLNIDTo'] = trxGLNIDTo;
    return data;
  }
}
