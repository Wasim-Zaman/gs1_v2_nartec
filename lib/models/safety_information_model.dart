class SafetyInformationModel {
  String? iD;
  String? safetyDetailedInformation;
  String? linkType;
  String? lang;
  String? targetURL;
  String? gTIN;

  SafetyInformationModel(
      {this.iD,
      this.safetyDetailedInformation,
      this.linkType,
      this.lang,
      this.targetURL,
      this.gTIN});

  SafetyInformationModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    safetyDetailedInformation = json['SafetyDetailedInformation'];
    linkType = json['LinkType'];
    lang = json['Lang'];
    targetURL = json['TargetURL'];
    gTIN = json['GTIN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['SafetyDetailedInformation'] = safetyDetailedInformation;
    data['LinkType'] = linkType;
    data['Lang'] = lang;
    data['TargetURL'] = targetURL;
    data['GTIN'] = gTIN;
    return data;
  }
}
