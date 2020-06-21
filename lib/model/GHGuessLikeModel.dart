class GHGuessLikeModel {
  List<GHGuessLikeItemModel> results;

  GHGuessLikeModel({this.results});

  GHGuessLikeModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<GHGuessLikeItemModel>();
      json['results'].forEach((v) {
        results.add(new GHGuessLikeItemModel.fromJson(v));
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

class GHGuessLikeItemModel {

  Object price;   //所有的类型都继承 Object
  String url;

  GHGuessLikeItemModel(
      {
        this.price,

        this.url,
       });

  GHGuessLikeItemModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];

    price = json['price'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['price'] = this.price;

    data['url'] = this.url;

    return data;
  }
}