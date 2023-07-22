class SubscriptionListModel {
  List<String>? products;

  SubscriptionListModel({this.products});

  SubscriptionListModel.fromJson(Map<String, dynamic> json) {
    products = json['products'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['products'] = products;
    return data;
  }
}
