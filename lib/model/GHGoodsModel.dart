class GHGoodsModel {
  List<GHGoodsItemModel> results;

  GHGoodsModel({this.results});

  GHGoodsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<GHGoodsItemModel>();
      json['results'].forEach((v) {
        results.add(new GHGoodsItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GHGoodsItemModel {
  String description;
  String updatedAt;
  String evaluate;
  String objectId;
  String createdAt;
  String title;
  String url;
  int price;
  int sales;
  String isSelf;

  GHGoodsItemModel(
      {this.description,
        this.updatedAt,
        this.evaluate,
        this.objectId,
        this.createdAt,
        this.title,
        this.url,
        this.sales,
        this.isSelf,
        this.price});

  GHGoodsItemModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    updatedAt = json['updatedAt'];
    evaluate = json['evaluate'];
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    title = json['title'];
    url = json['url'];
    sales = json['sales'];
    isSelf = json['isSelf'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['updatedAt'] = this.updatedAt;
    data['evaluate'] = this.evaluate;
    data['objectId'] = this.objectId;
    data['createdAt'] = this.createdAt;
    data['title'] = this.title;
    data['url'] = this.url;
    data['sales'] = this.sales;
    data['price'] = this.price;
    data['isSelf'] = this.isSelf;
    return data;
  }
}