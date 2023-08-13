class RecipeModel {
  String? iD;
  String? logo;
  String? title;
  String? description;
  String? ingredients;
  String? linkType;
  String? gTIN;

  RecipeModel(
      {this.iD,
      this.logo,
      this.title,
      this.description,
      this.ingredients,
      this.linkType,
      this.gTIN});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    logo = json['logo'];
    title = json['title'];
    description = json['description'];
    ingredients = json['ingredients'];
    linkType = json['LinkType'];
    gTIN = json['GTIN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['logo'] = logo;
    data['title'] = title;
    data['description'] = description;
    data['ingredients'] = ingredients;
    data['LinkType'] = linkType;
    data['GTIN'] = gTIN;
    return data;
  }
}
