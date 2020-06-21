class GHCategoryModel {
  List<GHCategoryItemModel> results;

  GHCategoryModel({this.results});

  GHCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<GHCategoryItemModel>();
      json['results'].forEach((v) {
        results.add(new GHCategoryItemModel.fromJson(v));
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

class GHCategoryItemModel {

  String categoryName;   //所有的类型都继承 Object
  String type;
  String url;

  GHCategoryItemModel(
      {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['categoryName'] = this.categoryName;
    data['url'] = this.url;
    data['type'] = this.type;

    return data;
  }
}