// FocusModel.fromJson(json);
class FocusModel {
  List<FocusItemModel> result;
  FocusModel({this.result});
  FocusModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<FocusItemModel>();
      json['result'].forEach((v) {
        result.add(new FocusItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FocusItemModel {
  String sId;
  String title;
  String status;
  String pic;
  String url;

  FocusItemModel({this.sId, this.title, this.status, this.pic, this.url});
  FocusItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    pic = pic.replaceAll('\\', '/');
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['url'] = this.url;
    return data;
  }
}