class SocialMediaModel {
  String? imagePath;
  List<SocialLinks>? socialLinks;

  SocialMediaModel({this.imagePath, this.socialLinks});

  SocialMediaModel.fromJson(Map<String, dynamic> json) {
    imagePath = json['image_path'];
    if (json['socialLinks'] != null) {
      socialLinks = <SocialLinks>[];
      json['socialLinks'].forEach((v) {
        socialLinks!.add(SocialLinks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_path'] = imagePath;
    if (socialLinks != null) {
      data['socialLinks'] = socialLinks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SocialLinks {
  int? id;
  String? socialIcon;
  String? socialLink;

  SocialLinks({this.id, this.socialIcon, this.socialLink});

  SocialLinks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    socialIcon = json['social_icon'];
    socialLink = json['social_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['social_icon'] = socialIcon;
    data['social_link'] = socialLink;
    return data;
  }
}
