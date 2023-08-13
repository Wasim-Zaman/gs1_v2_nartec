class HomeHelpDeskModel {
  String? pageTitle;
  String? pageData;

  HomeHelpDeskModel({this.pageTitle, this.pageData});

  HomeHelpDeskModel.fromJson(Map<String, dynamic> json) {
    pageTitle = json['pageTitle'];
    pageData = json['pageData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageTitle'] = pageTitle;
    data['pageData'] = pageData;
    return data;
  }
}
