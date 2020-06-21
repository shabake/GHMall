class GHHotGoodsModel {
  List<GHHotGoodsItemModel> results;

  GHHotGoodsModel({this.results});

  GHHotGoodsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<GHHotGoodsItemModel>();
      json['results'].forEach((v) {
        results.add(new GHHotGoodsItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['result'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GHHotGoodsItemModel {

  String price;   //所有的类型都继承 Object
  String url;
  String oldPrice;
  String title;

  GHHotGoodsItemModel(
      {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['price'] = this.price;
    data['title'] = this.title;
    data['oldPrice'] = this.oldPrice;
    data['url'] = this.url;
    return data;
  }
}