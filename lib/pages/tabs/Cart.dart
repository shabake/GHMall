import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../Cart/CartItem.dart';
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';
import '../../services/httptool.dart';
import '../../model/GHHotGoodsModel.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:city_pickers/city_pickers.dart';
import '../../services/GHToast.dart';
import '../../widget/LoadingWidget.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  String _city = "";

  ///  热门推荐
  List _hotGoodsList = [];

  List list = ["2"];

  /// 实现保持状态
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _getHotGoodsData();
  }

  //获取热门商品的数据
  _getHotGoodsData() async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/shopHotGoods";
    await HttpRequest.request(url).then((value) {
      var list = new GHHotGoodsModel.fromJson(value).results;
      setState(() {
        this._hotGoodsList = list;
      });
    });
  }

  _showCityPicker(BuildContext context) async {
    Result result = await CityPickers.showCitiesSelector(
      context: context,
    );
    setState(() {
      this._city = result.cityName;
      GHToast.showTost("当前定位${this._city}");
    });
  }

  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    var cartProvider = Provider.of<Cart>(context);
    Widget _cartItem(value) {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/producttContent', arguments: {
            'id': value["_id"],
          });
        },
        child: Container(
          padding: EdgeInsets.all(5),
          height: ScreenAdaper.height(180),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          ))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 60,
                child: Checkbox(
                  value: value["checked"],
                  onChanged: (val) {
                    setState(() {
                      value["checked"] = !value["checked"];
                      cartProvider.itemChange(value);
                    });
                  },
                  activeColor: Colors.orange,
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Image.network(value["pic"], fit: BoxFit.cover),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          value["title"],
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          value["seletecAttr"],
                          maxLines: 2,
                        ),
                      ),
                      Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              value["price"],
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CartItem(value),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget _hotGoodstWidget() {
      if (this._hotGoodsList.length == 0) {
        return LoadingWidget();
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
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.red),
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
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 10),
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

    // 底部工具条
    Widget _bottomToolBar() {
      return Container(
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
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 60,
                      child: Checkbox(
                          value: cartProvider.isCheckAll,
                          activeColor: Colors.orange,
                          onChanged: (value) {
                            cartProvider.check(value);
                          }),
                    ),
                    Container(
                      child: Text("全选"),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "￥${cartProvider.totalPrice}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        color: Colors.orange,
                        width: 120,
                        height: 50,
                        child: InkWell(
                          onTap: () {
                            if (this.list.length == 0) {
                              Navigator.pushNamed(context, '/login');
                            } else {
                              Navigator.pushNamed(context, '/CheckOut');
                            }
                          },
                          child: Center(
                            child: Text(
                              "结算",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    /// 用户没有登录显示的界面
    Widget _notLoginWidgte() {
      return Container(
        /// 没有登录下的界面
        child: ListView(
          children: <Widget>[
            Container(
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
                              color: Color.fromRGBO(200, 200, 200, 1),
                              width: 1)),
                      child: InkWell(
                        onTap: () {
                          print("点击扥呼噜");
                        },
                        child: Text("登录"),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Text("登录后同步电脑与手机购物车中的商品"),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              alignment: Alignment.center,
              child: Text(
                "购物车是空",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
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
                    child: InkWell(
                      child: Text("随便看看",
                          style: TextStyle(fontWeight: FontWeight.bold)),
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
                              color: Color.fromRGBO(200, 200, 200, 1),
                              width: 1)),
                      child: InkWell(
                        child: Text(
                          "收藏商品",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),

            /// 热门推荐
            _hotGoodstWidget(),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text("购物车"),
              ),
              InkWell(
                  onTap: () {
                    this._showCityPicker(context);
                  },
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
                          this._city,
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
              onPressed: () {
                cartProvider.removeAllData();
              }),
        ],
      ),
      body: cartProvider.cartList.length > 0
          ? Stack(
              children: <Widget>[
                ListView(
                  children: cartProvider.cartList.map((value) {
                    return _cartItem(value);
                  }).toList(),
                ),
                Positioned(
                  width: ScreenAdaper.getScreenWidth(),
                  height: 50,
                  bottom: 0,
                  child: _bottomToolBar(),
                ),
              ],
            )
          : _notLoginWidgte(),
    );
  }
}
