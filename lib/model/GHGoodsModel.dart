class GHGoodsModel {
  List<GHGoodsItemModel>? results;

  GHGoodsModel({this.results});

  GHGoodsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <GHGoodsItemModel>[];
      json['results'].forEach((v) {
        results!.add(GHGoodsItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GHGoodsItemModel {
  String? description;
  String? updatedAt;
  String? evaluate;
  String? objectId;
  String? createdAt;
  String? title;
  String? url;
  int? price;
  int? sales;
  String? isSelf;

  GHGoodsItemModel({
    this.description,
    this.updatedAt,
    this.evaluate,
    this.objectId,
    this.createdAt,
    this.title,
    this.url,
    this.sales,
    this.isSelf,
    this.price,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['updatedAt'] = updatedAt;
    data['evaluate'] = evaluate;
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['title'] = title;
    data['url'] = url;
    data['sales'] = sales;
    data['price'] = price;
    data['isSelf'] = isSelf;
    return data;
  }
}