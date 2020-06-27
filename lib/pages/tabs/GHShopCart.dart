import 'package:flutter/material.dart';
import '../../model/GHHotGoodsModel.dart';
import '../../services/httptool.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../services/ScreenAdaper.dart';

/// 购物车
class GHShopCart extends StatefulWidget {
  @override
  _GHShopCartState createState() => _GHShopCartState();
}

class _GHShopCartState extends State<GHShopCart> {
  List _hotGoodsList = [];

  @override
  void initState() {
    super.initState();

    this._getHotGoodsData();
  }

  //获取热门商品的数据
  void _getHotGoodsData() async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/shopHotGoods";
    await HttpRequest.request(url).then((value) {
      var list = new GHHotGoodsModel.fromJson(value).results;
      setState(() {
        this._hotGoodsList = list;
      });
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
                        color: Colors.orange,
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
        IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Colors.black38,
            ),
            onPressed: () {}),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._appBar(),
      body: this._notLoginWidgte(),
    );
  }
}
