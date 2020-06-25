class GHGoodDetailsModel {
  String isSelf;
  String description;
  List<String> coupons;
  List<String> service;
  int sales;
  List<String> urls;
  String receiptTip;
  String updatedAt;
  String evaluate;
  String objectId;
  List<String> storeAdvantages;
  String createdAt;
  String title;
  Operators operators;
  String url;
  int price;

  GHGoodDetailsModel(
      {this.isSelf,
        this.description,
        this.coupons,
        this.service,
        this.sales,
        this.urls,
        this.receiptTip,
        this.updatedAt,
        this.evaluate,
        this.objectId,
        this.storeAdvantages,
        this.createdAt,
        this.title,
        this.operators,
        this.url,
        this.price});

  GHGoodDetailsModel.fromJson(Map<String, dynamic> json) {
    isSelf = json['isSelf'];
    description = json['description'];
    coupons = json['coupons'].cast<String>();
    service = json['service'].cast<String>();
    sales = json['sales'];
    urls = json['urls'].cast<String>();
    receiptTip = json['receiptTip'];
    updatedAt = json['updatedAt'];
    evaluate = json['evaluate'];
    objectId = json['objectId'];
    storeAdvantages = json['storeAdvantages'].cast<String>();
    createdAt = json['createdAt'];
    title = json['title'];
    operators = json['operators'] != null
        ? new Operators.fromJson(json['operators'])
        : null;
    url = json['url'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSelf'] = this.isSelf;
    data['description'] = this.description;
    data['coupons'] = this.coupons;
    data['service'] = this.service;
    data['sales'] = this.sales;
    data['urls'] = this.urls;
    data['receiptTip'] = this.receiptTip;
    data['updatedAt'] = this.updatedAt;
    data['evaluate'] = this.evaluate;
    data['objectId'] = this.objectId;
    data['storeAdvantages'] = this.storeAdvantages;
    data['createdAt'] = this.createdAt;
    data['title'] = this.title;
    if (this.operators != null) {
      data['operators'] = this.operators.toJson();
    }
    data['url'] = this.url;
    data['price'] = this.price;
    return data;
  }
}

class Operators {
  List<Operator> operator;

  Operators({this.operator});

  Operators.fromJson(Map<String, dynamic> json) {
    if (json['operator'] != null) {
      operator = new List<Operator>();
      json['operator'].forEach((v) {
        operator.add(new Operator.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.operator != null) {
      data['operator'] = this.operator.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Operator {
  String title;

  Operator({this.title});

  Operator.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    return data;
  }
}

