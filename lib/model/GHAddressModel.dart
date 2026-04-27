
class GHAddressModel {
  List<Results>? results;

  GHAddressModel({this.results});

  GHAddressModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
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

class Results {
  String? province;
  String? area;
  String? city;
  String? detailsAddress;
  String? remark;
  String? zone;
  String? phone;
  String? userId;
  String? objectId;
  String? updatedAt;
  String? createdAt;
  String? name;
  String? isDefault;
  Where? where;

  Results({
    this.detailsAddress,
    this.remark,
    this.province,
    this.area,
    this.city,
    this.zone,
    this.phone,
    this.userId,
    this.objectId,
    this.updatedAt,
    this.createdAt,
    this.name,
    this.isDefault,
    this.where,
  });

  Results.fromJson(Map<String, dynamic> json) {
    detailsAddress = json['detailsAddress'] ?? "暂无地址";
    remark = json['remark'];
    zone = json['zone'] ?? "暂无地址";
    phone = json['phone'] ?? "13800000000";
    userId = json['userId'];
    objectId = json['objectId'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    province = json['province'];
    city = json['city'];
    area = json['area'];
    name = json['name'] ?? "没有设置";
    isDefault = json['isDefault'];
    where = json['where'] != null ? Where.fromJson(json['where']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detailsAddress'] = detailsAddress;
    data['remark'] = remark;
    data['zone'] = zone;
    data['phone'] = phone;
    data['userId'] = userId;
    data['objectId'] = objectId;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['name'] = name;
    data['isDefault'] = isDefault;
    data['province'] = province;
    data['city'] = city;
    data['area'] = area;

    if (where != null) {
      data['where'] = where!.toJson();
    }
    return data;
  }
}

class Where {
  String? token;
  String? userId;

  Where({this.token, this.userId});

  Where.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['userId'] = userId;
    return data;
  }
}

