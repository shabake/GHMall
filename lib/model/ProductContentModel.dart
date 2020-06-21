class ProductContentModel {
  ProductContentItemModel result;

  ProductContentModel({this.result});

  ProductContentModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null
        ? new ProductContentItemModel.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class ProductContentItemModel {
  String sId;
  String title;
  String cid;
  Object price;
  String oldPrice;
  Object isBest;
  Object isHot;
  Object isNew;
  String status;
  String pic;
  String content;
  String cname;
  List<Attr> attr;
  String subTitle;
  Object salecount;
  int count;
  String seletecAttr;

  ProductContentItemModel(
      {this.sId,
      this.title,
      this.cid,
      this.price,
      this.oldPrice,
      this.isBest,
      this.isHot,
      this.isNew,
      this.status,
      this.pic,
      this.content,
      this.cname,
      this.attr,
      this.subTitle,
      this.count,
      this.seletecAttr,
      this.salecount});

  ProductContentItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    oldPrice = json['old_price'];
    isBest = json['is_best'];
    isHot = json['is_hot'];
    isNew = json['is_new'];
    status = json['status'];
    pic = json['pic'];
    content = json['content'];
    cname = json['cname'];
    if (json['attr'] != null) {
      attr = new List<Attr>();
      json['attr'].forEach((v) {
        attr.add(new Attr.fromJson(v));
      });
    }
    subTitle = json['sub_title'];
    salecount = json['salecount'];
    count = 1;
    seletecAttr = '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['cid'] = this.cid;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['is_best'] = this.isBest;
    data['is_hot'] = this.isHot;
    data['is_new'] = this.isNew;
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['content'] = this.content;
    data['cname'] = this.cname;
    if (this.attr != null) {
      data['attr'] = this.attr.map((v) => v.toJson()).toList();
    }
    data['sub_title'] = this.subTitle;
    data['salecount'] = this.salecount;
    return data;
  }
}

class Attr {
  String cate;
  List<String> list;
  List<Map> attrList;

  Attr({this.cate, this.list});

  Attr.fromJson(Map<String, dynamic> json) {
    cate = json['cate'];
    list = json['list'].cast<String>();
    attrList = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cate'] = this.cate;
    data['list'] = this.list;
    return data;
  }
}
