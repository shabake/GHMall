import 'package:flutter/material.dart';
import '../../model/GHHotGoodsModel.dart';
import '../../services/httptool.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../services/ScreenAdaper.dart';
import "../../model/GHGoodDetailsModel.dart";
import '../../widget/GHCountItemWidget.dart';
import '../../widget/LoadingWidget.dart';

/// 购物车
class GHShopCart extends StatefulWidget {
  @override
  _GHShopCartState createState() => _GHShopCartState();
}

class _GHShopCartState extends State<GHShopCart> {
  /// 热卖商品
  List _hotGoodsList = [];

  /// 购物车列表
  List _shopCartList = [];

  /// 记录是否已经全选
  bool _isAllCheck = false;

  /// 编辑/完成
  bool _isEdit = false;

  /// 共计
  double _total = 0;

  @override

  void initState() {
    super.initState();

    this._getHotGoodsData();
    this._getShopCartList();
  }

  /// 获取购物车列表
  void _getShopCartList() async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/shopCartList";
    var c = Uri.encodeComponent('-createdAt');
    url = url + '?' + "order=" + c;
    HttpRequest.request(url, method: 'GET').then((res) {
      List _tempList = [];
      List _results = res["results"];
      _results.forEach((item) {
        GHGoodDetailsModel goodDetailsModel =
            new GHGoodDetailsModel.fromJson(item);
        _tempList.add(goodDetailsModel);
      });

      double _tempTotal = 0;
      bool _tempIsAllCheck = true;
      for (var i = 0; i < _tempList.length; i++) {
        GHGoodDetailsModel goodDetailsModel = _tempList[i];
        if (goodDetailsModel.check == true) {
          _tempTotal += goodDetailsModel.count * goodDetailsModel.price;
        } else {
          _tempIsAllCheck = false;
        }
      }

      setState(() {
        this._shopCartList = _tempList;
        this._total = _tempTotal;
        this._isAllCheck = _tempIsAllCheck;
      });
    });
  }

  /// 获取热门商品的数据
  void _getHotGoodsData() async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/shopHotGoods";
    await HttpRequest.request(url).then((value) {
      var list = new GHHotGoodsModel.fromJson(value).results;
      setState(() {
        this._hotGoodsList = list;
      });
    });
  }

  /// 修改购物车中的商品
  void _updateShopCartList(
      GHGoodDetailsModel goodDetailsModel, String goodId) async {
    var url =
        "https://a4cj1hm5.api.lncld.net/1.1/classes/shopCartList/${goodId}";
    Map<String, dynamic> params = {
      "count": goodDetailsModel.count,
      "check": goodDetailsModel.check,
    };
    HttpRequest.request(url, method: 'PUT', params: params).then((value) {
      var objectId = value["objectId"];
      if (objectId != null) {
        print("更新成功");
        this._getShopCartList();
      } else {
        print("更新失败");
      }
    });
  }

  /// 热销商品widget
  Widget _hotGoodstWidget() {
    if (this._hotGoodsList.length == 0) {
      return Text("");
    }
    return Container(
      color: Color.fromRGBO(245, 245, 245, 1),
      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: this._hotGoodsList.map((value) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
              padding:
                  EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
              width: (ScreenAdaper.getScreenWidth() - 30) / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 100,
                    child: new FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: "${value.url}",
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    child: Text(
                      "${value.title}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            child: Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "￥",
                                style:
                                    TextStyle(fontSize: 10, color: Colors.red),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${value.price}",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )),
                        Container(
                          height: 21,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromRGBO(233, 233, 233, 0.9),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "看详情",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ));
        }).toList(),
      ),
    );
  }

  /// 没有登录的登录
  Widget _notLoginLetLoginWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              height: 30,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Color.fromRGBO(200, 200, 200, 1), width: 1)),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  print("点击登录");
                },
                child: Text(
                  "登录",
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                ),
              )),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              "登录后同步电脑与手机购物车中的商品",
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  /// 空的购物车
  Widget _emptyShopCartWidget() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "购物车是空",
        style: TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  /// 未登录导航
  Widget _notLoginNavigationWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: Color.fromRGBO(200, 200, 200, 1), width: 1)),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Text("随便看看",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Color.fromRGBO(200, 200, 200, 1), width: 1)),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Text(
                  "收藏商品",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              )),
        ],
      ),
    );
  }

  Widget _recommendWidget() {
    return Container(
      height: 50,
      color: Color.fromRGBO(245, 245, 245, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Icon(
              Icons.hearing,
              color: Colors.red,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              "为你推荐",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  /// 没有登录
  Widget _notLoginWidgte() {
    return Container(
      child: ListView(
        children: <Widget>[
          this._notLoginLetLoginWidget(),
          Divider(),
          this._emptyShopCartWidget(),
          SizedBox(
            height: 10,
          ),
          this._notLoginNavigationWidget(),
          SizedBox(
            height: 10,
          ),
          this._recommendWidget(),

          /// 热门推荐
          this._hotGoodstWidget(),
        ],
      ),
    );
  }

  /// 自定义appBar
  Widget _appBar() {
    return AppBar(
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text("购物车"),
            ),
            InkWell(
                onTap: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.location_on,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      child: Text(
                        "2",
                        style: TextStyle(fontSize: 12, color: Colors.black38),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
      actions: <Widget>[
        Container(
            margin: EdgeInsets.only(right: 20),
            alignment: Alignment.center,
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    this._isEdit = !this._isEdit;
                  });
                },
                child: Text(
                  this._isEdit == false ? "编辑" : "完成",
                  style: TextStyle(fontSize: 14, color: Colors.black38),
                )))
      ],
    );
  }

  /// 批量处理全选
  void _actionAllCheck(bool isAllCheck) {
    List maps = [];
    for (var i = 0; i < this._shopCartList.length; i++) {
      GHGoodDetailsModel goodDetailsModel = _shopCartList[i];
      Map map = {
        "method": "PUT",
        "path": "/1.1/classes/shopCartList/${goodDetailsModel.objectId}",
        "body": {"check": isAllCheck}
      };
      maps.add(map);
    }
    var url = "https://a4cj1hm5.api.lncld.net/1.1/batch";

    Map<String, dynamic> params = {"requests": maps};

    HttpRequest.request(url, method: 'POST', params: params).then((value) {
      if (value != null) {
        this._getShopCartList();
      } else {
        print("更新失败");
      }
    });
  }

  /// 底部工具条
  Widget _bottomToolBar() {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          width: 1,
          color: Colors.black12,
        ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20),
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: 20,
                      height: 20,
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              this._isAllCheck = !this._isAllCheck;
                            });
                            this._actionAllCheck(this._isAllCheck);
                          },
                          child: this._isAllCheck == true
                              ? Image.asset('images/checkSelected.png')
                              : Image.asset('images/checkNormal.png'))),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "全选",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
            this._isEdit == false
                ? Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: RichText(
                              text: TextSpan(
                                  text: "¥",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 10),
                                  children: [
                                TextSpan(
                                    text: "${this._total}",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: ".00",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                              ])),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            color: Colors.red,
                            width: 120,
                            height: 50,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {

                            Navigator.pushNamed(context, '/CheckOut');

                              },
                              child: Center(
                                child: Text(
                                  "结算",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ))
                      ],
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Color.fromRGBO(200, 200, 200, 1), width: 1)),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        print("点击删除");
                      },
                      child: Text(
                        "删除",
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    )),
          ],
        ),
      ),
    );
  }

  /// 购物车子项
  Widget _shopCartItem(GHGoodDetailsModel goodDetailsModel) {
    return Container(
        padding: EdgeInsets.only(left: 20,right: 10,bottom: 10,top: 10),
        height: 130,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 20,
                height: 20,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        goodDetailsModel.check = !goodDetailsModel.check;
                      });
                      this._updateShopCartList(
                          goodDetailsModel, goodDetailsModel.objectId);
                    },
                    child: goodDetailsModel.check == true
                        ? Image.asset('images/checkSelected.png')
                        : Image.asset('images/checkNormal.png'))),
            Expanded(
                flex: 1,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/GHGoodsDetails',
                          arguments: {
                            'id': goodDetailsModel.goodId,
                          });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(right: 10),
                                height: 100,
                                width: 100,
                                child: new FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: goodDetailsModel.url,
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 110,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Text(
                                                goodDetailsModel.title,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              color: Colors.black12,
                                              child: Text(
                                                goodDetailsModel
                                                    .seletecdStrings,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                        Container(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: "¥",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 10),
                                                      children: [
                                                    TextSpan(
                                                        text:
                                                            "${goodDetailsModel?.price}",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    TextSpan(
                                                        text: ".00",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ])),
                                            ),
                                            Container(
                                              child: GHCountItemWidger(
                                                count: goodDetailsModel.count,
                                                addClick: (value) {
                                                  setState(() {
                                                    goodDetailsModel.count =
                                                        value;
                                                  });
                                                  this._updateShopCartList(
                                                      goodDetailsModel,
                                                      goodDetailsModel
                                                          .objectId);
                                                },
                                                subClick: (value) {
                                                  setState(() {
                                                    goodDetailsModel.count =
                                                        value;
                                                  });
                                                  this._updateShopCartList(
                                                      goodDetailsModel,
                                                      goodDetailsModel
                                                          .objectId);
                                                },
                                              ),
                                            )
                                          ],
                                        ))
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    )))
          ],
        ));
  }

  /// 购物车列表
  Widget _shopCartWidget() {
    return Stack(
      children: <Widget>[
        Container(
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 50),
            height: ScreenAdaper.getScreenHeight() ,
            child: ListView.builder(
                itemCount: this._shopCartList.length,
                itemBuilder: (BuildContext context, index) {
                  return this._shopCartItem(this._shopCartList[index]);
                })),
        Positioned(
          width: ScreenAdaper.getScreenWidth(),
          height: 50,
          bottom: 0,
          child: this._bottomToolBar(),
        ),
      ],
    );
  }

  /// 判断bodywidget
  Widget _bodyWidgt() {
    if (this._shopCartList.length == 0) {
      return LoadingWidget();
    }
    return this._shopCartWidget();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._appBar(),
      body: this._bodyWidgt(),
    );
  }
}
