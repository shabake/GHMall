
class GHAddressModel {
  List<Results> results;

  GHAddressModel({this.results});

  GHAddressModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
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

class Results {
  String province;
  String area;
  String city;
  String detailsAddress;
  String remark;
  String zone;
  String phone;
  String userId;
  String objectId;
  String updatedAt;
  String createdAt;
  String name;
  String isDefault;
  Where where;

  Results(
      {this.detailsAddress,
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
        this.where});

  Results.fromJson(Map<String, dynamic> json) {
    detailsAddress = json['detailsAddress'];
    if (detailsAddress == null) {
      detailsAddress = "暂无地址";
    }
    remark = json['remark'];
    zone = json['zone'];
    if (zone == null) {
      zone = "暂无地址";
    }
    phone = json['phone'];
    if (phone == null) {
      phone = "13800000000";
    }
    userId = json['userId'];
    objectId = json['objectId'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    province = json['province'];
    city = json['city'];
    area = json['area'];
    name = json['name'];
    if (name == null) {
      name = "没有设置";
    }
    isDefault = json['isDefault'];
    where = json['where'] != null ? new Where.fromJson(json['where']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detailsAddress'] = this.detailsAddress;
    data['remark'] = this.remark;
    data['zone'] = this.zone;
    data['phone'] = this.phone;
    data['userId'] = this.userId;
    data['objectId'] = this.objectId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['name'] = this.name;
    data['isDefault'] = this.isDefault;
    data['province'] = this.province;
    data['city'] = this.city;
    data['area'] = this.area;


    if (this.where != null) {
      data['where'] = this.where.toJson();
    }
    return data;
  }
}

class Where {
  String token;
  String userId;

  Where({this.token, this.userId});

  Where.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['userId'] = this.userId;
    return data;
  }
}

