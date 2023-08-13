class GLNModel {
  String? gcpGLNID;
  String? locationNameEn;
  String? locationNameAr;
  String? addressAr;
  String? addressEn;
  String? pobox;
  String? postalCode;
  String? longitude;
  String? latitude;
  String? image;
  String? gLNBarcodeNumber;
  String? status;

  GLNModel(
      {this.gcpGLNID,
      this.locationNameEn,
      this.locationNameAr,
      this.addressAr,
      this.addressEn,
      this.pobox,
      this.postalCode,
      this.longitude,
      this.latitude,
      this.image,
      this.gLNBarcodeNumber,
      this.status});

  GLNModel.fromJson(Map<String, dynamic> json) {
    gcpGLNID = json['gcpGLNID'];
    locationNameEn = json['locationNameEn'];
    locationNameAr = json['locationNameAr'];
    addressAr = json['AddressAr'];
    addressEn = json['AddressEn'];
    pobox = json['pobox'];
    postalCode = json['postal_code'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    image = json['image'];
    gLNBarcodeNumber = json['GLNBarcodeNumber'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gcpGLNID'] = gcpGLNID;
    data['locationNameEn'] = locationNameEn;
    data['locationNameAr'] = locationNameAr;
    data['AddressAr'] = addressAr;
    data['AddressEn'] = addressEn;
    data['pobox'] = pobox;
    data['postal_code'] = postalCode;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['image'] = image;
    data['GLNBarcodeNumber'] = gLNBarcodeNumber;
    data['status'] = status;
    return data;
  }
}
