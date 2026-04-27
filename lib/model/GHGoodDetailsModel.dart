class GHGoodDetailsModel {
  String? isSelf;
  String? description;
  List<String>? coupons;
  List<String>? service;
  int? sales;
  List<String>? urls;
  String? receiptTip;
  String? updatedAt;
  String? evaluate;
  String? objectId;
  List<String>? storeAdvantages;
  String? createdAt;
  String? title;
  String? goodId;
  Operators? operators;
  String? url;
  Object? price;
  int? count;
  String? seletecdStrings;
  bool? check;

  GHGoodDetailsModel({
    this.isSelf,
    this.description,
    this.coupons,
    this.service,
    this.sales,
    this.urls,
    this.receiptTip,
    this.updatedAt,
    this.evaluate,
    this.objectId,
    this.goodId,
    this.storeAdvantages,
    this.createdAt,
    this.title,
    this.operators,
    this.url,
    this.count,
    this.seletecdStrings,
    this.check,
    this.price,
  });

  GHGoodDetailsModel.fromJson(Map<String, dynamic> json) {
    isSelf = json['isSelf'];
    description = json['description'];
    Object? tempCoupons = json['coupons'];
    if (tempCoupons is List) {
      coupons = tempCoupons.cast<String>();
    } else {
      coupons = [];
    }

    Object? tempservice = json['service'];
    if (tempservice is List) {
      service = tempservice.cast<String>();
    } else {
      service = [];
    }

    sales = json['sales'];

    Object? tempurls = json['urls'];
    if (tempurls is List) {
      urls = tempurls.cast<String>();
    } else {
      urls = [];
    }
    count = json['count'];
    check = json['check'];
    goodId = json['goodId'];
    receiptTip = json['receiptTip'];
    updatedAt = json['updatedAt'];
    evaluate = json['evaluate'];
    objectId = json['objectId'];
    Object? tempstoreAdvantages = json['storeAdvantages'];
    if (tempstoreAdvantages is List) {
      storeAdvantages = tempstoreAdvantages.cast<String>();
    } else {
      storeAdvantages = [];
    }

    createdAt = json['createdAt'];
    title = json['title'];
    operators = json['operators'] != null
        ? Operators.fromJson(json['operators'])
        : null;
    url = json['url'];
    price = json['price'];
    seletecdStrings = json['seletecdStrings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSelf'] = isSelf;
    data['description'] = description;
    data['coupons'] = coupons;
    data['service'] = service;
    data['sales'] = sales;
    data['urls'] = urls;
    data['receiptTip'] = receiptTip;
    data['updatedAt'] = updatedAt;
    data['evaluate'] = evaluate;
    data['objectId'] = objectId;
    data['count'] = count;
    data['check'] = check;
    data['storeAdvantages'] = storeAdvantages;
    data['createdAt'] = createdAt;
    data['title'] = title;
    data['goodId'] = goodId;
    data['seletecdStrings'] = seletecdStrings;
    if (operators != null) {
      data['operators'] = operators!.toJson();
    }
    data['url'] = url;
    data['price'] = price;
    return data;
  }
}

class Operators {
  List<Operator>? operator;

  Operators({this.operator});

  Operators.fromJson(Map<String, dynamic> json) {
    if (json['operator'] != null) {
      operator = <Operator>[];
      json['operator'].forEach((v) {
        operator!.add(Operator.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (operator != null) {
      data['operator'] = operator!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Operator {
  String? title;

  Operator({this.title});

  Operator.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    return data;
  }
}
