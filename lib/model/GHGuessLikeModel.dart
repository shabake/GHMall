class GHGuessLikeModel {
  List<GHGuessLikeItemModel>? results;

  GHGuessLikeModel({this.results});

  GHGuessLikeModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <GHGuessLikeItemModel>[];
      json['results'].forEach((v) {
        results!.add(GHGuessLikeItemModel.fromJson(v));
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

class GHGuessLikeItemModel {
  Object? price;
  String? url;

  GHGuessLikeItemModel({
    this.price,
    this.url,
  });

  GHGuessLikeItemModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['url'] = url;
    return data;
  }
}