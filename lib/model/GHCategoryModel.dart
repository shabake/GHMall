class GHCategoryModel {
  List<GHCategoryItemModel>? results;

  GHCategoryModel({this.results});

  GHCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <GHCategoryItemModel>[];
      json['results'].forEach((v) {
        results!.add(GHCategoryItemModel.fromJson(v));
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

class GHCategoryItemModel {
  String? categoryName;
  String? type;
  String? url;

  GHCategoryItemModel({
    this.categoryName,
    this.type,
    this.url,
  });

  GHCategoryItemModel.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    url = json['url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryName'] = categoryName;
    data['url'] = url;
    data['type'] = type;
    return data;
  }
}