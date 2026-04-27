class GHHotGoodsModel {
  List<GHHotGoodsItemModel>? results;

  GHHotGoodsModel({this.results});

  GHHotGoodsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <GHHotGoodsItemModel>[];
      json['results'].forEach((v) {
        results!.add(GHHotGoodsItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['result'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GHHotGoodsItemModel {
  String? price;
  String? url;
  String? oldPrice;
  String? title;

  GHHotGoodsItemModel({
    this.price,
    this.oldPrice,
    this.title,
    this.url,
  });

  GHHotGoodsItemModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    oldPrice = json['oldPrice'];
    title = json['title'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['title'] = title;
    data['oldPrice'] = oldPrice;
    data['url'] = url;
    return data;
  }
}