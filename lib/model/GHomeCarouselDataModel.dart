class GHomeCarouselDataModel {
  List<GHomeCarouselDataItemModel>? results;

  GHomeCarouselDataModel({this.results});

  GHomeCarouselDataModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <GHomeCarouselDataItemModel>[];
      json['results'].forEach((v) {
        results!.add(GHomeCarouselDataItemModel.fromJson(v));
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

class GHomeCarouselDataItemModel {
  String? objectId;
  String? updatedAt;
  String? url;
  String? createdAt;

  GHomeCarouselDataItemModel({
    this.objectId,
    this.updatedAt,
    this.url,
    this.createdAt,
  });

  GHomeCarouselDataItemModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    updatedAt = json['updatedAt'];
    url = json['url'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['updatedAt'] = updatedAt;
    data['url'] = url;
    data['createdAt'] = createdAt;
    return data;
  }
}