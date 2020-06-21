import 'package:flutter/material.dart';
import '../widget/GHButton.dart';
import '../widget/GHTextWidget.dart';
import '../services/ScreenAdaper.dart';
import 'package:city_pickers/city_pickers.dart';
import '../services/httptool.dart';
import '../widget/GHLoading.dart';
import '../services/GHToast.dart';

/// 编辑/新增收货地址
class GHAddressEdit extends StatefulWidget {
  final Map arguments;

  @override
  GHAddressEdit({Key key, this.arguments}) : super(key: key);
  _GHAddressEditState createState() => _GHAddressEditState();
}

class _GHAddressEditState extends State<GHAddressEdit> {
  /// 收件人姓名
  String _name = "";

  /// 收货人电话
  String _phoneNumber = "";

  /// 省份
  String _province = "省";

  /// 市
  String _city = "市";

  /// 区
  String _area = "区";

  /// 省编码
  String _locationCode = "110000";

  /// 详细地址
  String _detailsAddress = "";

  /// 完整地址
  String _fullAddress = "";

  TextEditingController _addressController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _detailsAddressController = new TextEditingController();

  FocusNode _contentFocusNode = FocusNode();

  void initState() {
    super.initState();
    if (widget.arguments != null) {
      this._nameController.text = widget.arguments["name"];
      this._phoneNumberController.text = widget.arguments["phoneNumber"];
      this._addressController.text = widget.arguments["address"];
    }
  }



  _changeAddress() {

  }

  bool _checkAddress(){
    if(this._nameController.text.isEmpty
        ||this._phoneNumberController.text.isEmpty
        ||this._province.isEmpty
        ||this._city.isEmpty
        ||this._area.isEmpty
        ||this._detailsAddressController.text.isEmpty) {
      GHToast.showTost("地址信息填写不全");
      return false;
    }
    return true;
  }

  _addAddress(BuildContext context) {

    var url =
        "https://a4cj1hm5.api.lncld.net/1.1/classes/shopAddress";
    Map<String, dynamic> params ={
      'name':this._nameController.text,
      'phoneNumber':this._phoneNumberController.text,
      'province':this._province,
      'city':this._city,
      'area':this._area,
      'detailsAddress':this._detailsAddressController.text,
    };
    HttpRequest.request(url, method: 'POST',params:params).then((value) {
      var objectId = value["objectId"];
      if (objectId != null) {
        GHToast.showTost("添加地址成功");
        Navigator.pop(context);
      }
    });
  }

  _getAddress() {
    var url =
        "https://a4cj1hm5.api.lncld.net/1.1/classes/addressDetails/${widget.arguments["objectId"]}";
    HttpRequest.request(url, method: 'GET').then((value) {
      print(value);
    });
  }

  _deletecdAddress(BuildContext context) {
    var url =
        "https://a4cj1hm5.api.lncld.net/1.1/classes/addressDetails/${widget.arguments["objectId"]}";
    HttpRequest.request(url, method: 'DELETE').then((value) {
      GHToast.showTost("删除成功");
      Navigator.pop(context);
    });
  }

  _showCityPicker(BuildContext context) async {
    Result result = await CityPickers.showCityPicker(
      cancelWidget: Container(
        child: Text(
          "取消",
          style: TextStyle(fontSize: 16),
        ),
      ),
      locationCode: this._locationCode,
      confirmWidget: Container(
        child: Text(
          "确定",
          style: TextStyle(fontSize: 16),
        ),
      ),
      height: 300,
      context: context,
    );
    //{"provinceName":"北京市","provinceId":"110000",
    // "cityName":"北京城区","cityId":"110100",
    // "areaName":"东城区","areaId":"110101"}
    setState(() {
      this._province = result.provinceName;
      this._city = result.cityName;
      this._area = result.areaName;
      this._locationCode = result.provinceId;
      this._fullAddress = _province + _city + _area;
    });
  }

  @override

  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  _contentFocusNode.unfocus();
                  _deletecdAddress(context);
                },
                child: Text("删除"))
          ],
          title: widget.arguments == null ? Text("新增收货地址"):Text("新增收货地址"),
        ),
        body: GestureDetector(
          onTap: () {
            _contentFocusNode.unfocus();
          },
          child: Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                Container(
                  child: GHTextWidget(
                    "收件人姓名",
                    textEditingController: _nameController,
                  ),
                ),
                Container(
                  child: GHTextWidget(
                    "收件人电话",
                    textEditingController: _phoneNumberController,
                  ),
                ),
                Container(
                  child: InkWell(
                    onTap: () {
                      this._showCityPicker(context);
                    },
                    child: Container(
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${this._province} /${this._city}/${this._area}",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.black12,
                ),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Container(
                      child: TextField(
                          controller: this._detailsAddressController,
                          focusNode: this._contentFocusNode,
                          maxLines: null,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 0, top: 0),
                            hintText: "详细地址",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: GHButton(
                        "确定",
                        tapAction: () {
                          _contentFocusNode.unfocus();
                          if(this._checkAddress()) {
                            this._addAddress(context);
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
