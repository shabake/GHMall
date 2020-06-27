import 'dart:convert';
import '../services/Storage.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List _cartList = [];
  bool _isCheckAll = false;
  double _totalPrice = 0.0;

  List get cartList => this._cartList;

  bool get isCheckAll => this._isCheckAll;

  double get totalPrice => this._totalPrice;

  Cart() {
    this.init();
  }

  init() async {
    try {
      List cartListData = json.decode(await Storage.getString('cartList'));
      this._cartList = cartListData;
      print("初始化");
      print(cartListData);
    } catch (e) {
      this._cartList = [];
    }
    this.isCheckAllMember();
    getTotalPrice();
    notifyListeners();
  }

  addList(value) {
    _cartList.add(value);
    notifyListeners();
  }

  updataCartList() {
    this.init();
  }

  changeCartList() {
    Storage.setString('cartList', json.encode(this._cartList));
    getTotalPrice();
    notifyListeners();
  }

  check(value) {
    for (var i = 0; i < this._cartList.length; i++) {
      this._cartList[i]["checked"] = value;
    }
    this._isCheckAll = value;
    Storage.setString('cartList', json.encode(this._cartList));
    isCheckAllMember();
    getTotalPrice();
    notifyListeners();
  }

  /// 判断全选按钮状态
  isCheckAllMember() async {
    List cartListData = json.decode(await Storage.getString('cartList'));
    print(cartListData);
    if (cartListData.length > 0) {
      for (var i = 0; i < cartListData.length; i++) {
        if (cartListData[i]["checked"] == false) {
          _isCheckAll = false;
          print("取消");
          break;
        }
        _isCheckAll = true;
        print("轩重工");
      }
    }
  }

  itemChange(value) async {
    for (var i = 0; i < this.cartList.length; i++) {
      String seletecAttr =
          this.cartList[i]["_id"] + this.cartList[i]['seletecAttr'];
      String attr = value["_id"] + value['seletecAttr'];

      if (attr == seletecAttr) {
        this.cartList[i]["checked"] = value["checked"];
      }
    }
    Storage.setString('cartList', json.encode(this._cartList));
    isCheckAllMember();
    getTotalPrice();
    notifyListeners();
  }

  removeAllData() {
    Storage.remove("cartList");
    getTotalPrice();
    this.cartList.clear();
    notifyListeners();
  }

  getTotalPrice() {
    double totalPrice = 0;
    for (var i = 0; i < this.cartList.length; i++) {
      if (this.cartList[i]["checked"] == true) {
        String price = (this.cartList[i]["price"]);
        int count = (this.cartList[i]["count"]);
        totalPrice = double.parse(price) * count + totalPrice;
      }
    }
    this._totalPrice = totalPrice;
  }
}
