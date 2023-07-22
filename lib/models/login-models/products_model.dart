class ProductsModel {
  String? imagePath;
  List<Products>? products;

  ProductsModel({this.imagePath, this.products});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    imagePath = json['image_path'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_path'] = this.imagePath;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? gcpGLNID;
  String? productnameenglish;
  String? productnamearabic;
  String? brandName;
  String? brandNameAr;
  String? barcode;
  String? gpc;
  String? frontImage;
  String? backImage;

  Products(
      {this.gcpGLNID,
      this.productnameenglish,
      this.productnamearabic,
      this.brandName,
      this.brandNameAr,
      this.barcode,
      this.gpc,
      this.frontImage,
      this.backImage});

  Products.fromJson(Map<String, dynamic> json) {
    gcpGLNID = json['gcpGLNID'];
    productnameenglish = json['productnameenglish'];
    productnamearabic = json['productnamearabic'];
    brandName = json['BrandName'];
    brandNameAr = json['BrandNameAr'];
    barcode = json['barcode'];
    gpc = json['gpc'];
    frontImage = json['front_image'];
    backImage = json['back_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gcpGLNID'] = this.gcpGLNID;
    data['productnameenglish'] = this.productnameenglish;
    data['productnamearabic'] = this.productnamearabic;
    data['BrandName'] = this.brandName;
    data['BrandNameAr'] = this.brandNameAr;
    data['barcode'] = this.barcode;
    data['gpc'] = this.gpc;
    data['front_image'] = this.frontImage;
    data['back_image'] = this.backImage;
    return data;
  }
}
