class GHomeCarouselDataModel {
  List<GHomeCarouselDataItemModel> results;

  GHomeCarouselDataModel({this.results});

  GHomeCarouselDataModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<GHomeCarouselDataItemModel>();
      json['results'].forEach((v) {
        results.add(new GHomeCarouselDataItemModel.fromJson(v));
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

class GHomeCarouselDataItemModel {
  String objectId;
  String updatedAt;
  String url;
  String createdAt;
  GHomeCarouselDataItemModel({this.objectId, this.updatedAt, this.url, this.createdAt});

  GHomeCarouselDataItemModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    updatedAt = json['updatedAt'];
    url = json['url'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectId'] = this.objectId;
    data['updatedAt'] = this.updatedAt;
    data['url'] = this.url;
    data['createdAt'] = this.createdAt;
    return data;
  }
}