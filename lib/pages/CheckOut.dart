import 'package:flutter/material.dart';
import '../pages/Cart/CartItem.dart';
import '../services/httptool.dart';
import '../model/GHAddressModel.dart';
import '../services/ScreenAdaper.dart';
import 'Cart/CartItem.dart';
import 'package:provider/provider.dart';
import '../provider/Cart.dart';
import '../widget/LoadingWidget.dart';

/// 结算清单
class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  List list = List();

  Results results;

  _getAddressList() async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/shopAddress";
    await HttpRequest.request(url, method: 'GET').then((res) {
      Results firstModel = new GHAddressModel.fromJson(res).results.first;
      setState(() {
        results = firstModel;
        print(results);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    this._getAddressList();
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
          padding: EdgeInsets.all(20),
          height: ScreenAdaper.height(190),
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
                            child: CartItem(
                              value,
                              isEnable: false,
                            ),
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

    return Scaffold(
        appBar: AppBar(
          title: Text("订单页面"),
        ),
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                results == null
                    ? LoadingWidget()
                    : Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Container(
                                height: 50,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    results.name.isEmpty
                                        ? Text("没有获取到信息")
                                        : Text(
//                                  "2",
                                            results.name + results.phone,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                    Text(
                                      results.province +
                                          results.city +
                                          results.area +
                                          results.detailsAddress,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                )),
                          ],
                        )),
                Container(
                  height: 10,
                  color: Color.fromRGBO(245, 245, 245, 1),
                ),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: cartProvider.cartList.map((value) {
                    return _cartItem(value);
                  }).toList(),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 30,
                              child: Text(
                                "商品总额",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Container(
                              height: 30,
                              child: Text(
                                "￥${cartProvider.totalPrice}",
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 30,
                              child: Text("立减"),
                            ),
                            Container(
                              height: 30,
                              child: Text("￥0"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 30,
                              child: Text("优惠券￥0"),
                            ),
                            Container(
                              height: 30,
                              child: Text("￥0"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 30,
                              child: Text("运费"),
                            ),
                            Container(
                              height: 30,
                              child: Text("￥10"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                width: ScreenAdaper.getScreenWidth(),
                height: 89,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1, color: Colors.black12))),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "共计",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "￥${cartProvider.totalPrice + 10}",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 40,
                            color: Colors.red,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/OnlinePayments');
                              },
                              child: Text(
                                "立即下单",
                                style: TextStyle(color: Colors.white),
                              ),
                            ))
                      ],
                    ),
                  ),
                ))
          ],
        ));
  }
}
