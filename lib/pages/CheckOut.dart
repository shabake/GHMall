import 'package:flutter/material.dart';
import '../services/httptool.dart';
import '../model/GHAddressModel.dart';
import '../services/ScreenAdaper.dart';
import '../widget/LoadingWidget.dart';

/// 订单确认页
class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  List list = List();

  Results results;

  void _getAddressList() async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/shopAddress";
    await HttpRequest.request(url, method: 'GET').then((res) {
      Results firstModel = new GHAddressModel.fromJson(res).results.first;
      setState(() {
        results = firstModel;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    this._getAddressList();
  }

  /// 地址
  Widget _addressWidget() {
    return results == null
        ? LoadingWidget()
        : GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pushNamed(context, '/GHAddressList');
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 50,
                                  child: Text(
                                    results.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Text(
                                    results.phone,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: ScreenAdaper.getScreenWidth() - 20 - 20 - 30,
                            child: Text(
                              results.province +
                                  results.city +
                                  results.area +
                                  results.detailsAddress,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ));
  }

  /// 上方区域
  Widget _orderDetails() {
    return ListView(
      children: <Widget>[
        this._addressWidget(),
        Container(
          height: 10,
          color: Color.fromRGBO(245, 245, 245, 1),
        ),
//                ListView(
//                  shrinkWrap: true,
//                  physics: NeverScrollableScrollPhysics(),
//                  children: cartProvider.cartList.map((value) {
//                    return _cartItem(value);
//                  }).toList(),
//                ),
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
                        "2",
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
    );
  }

  /// 底部工具条
  Widget _bottomToolBar() {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: Colors.black12))),
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
                      "2",
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
    );
  }

  ///  bodyWidget
  Widget _bodyWidget() {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 90),
          child: _orderDetails(),
        ),
        Positioned(
          width: ScreenAdaper.getScreenWidth(),
          height: 90,
          bottom: 0,
          child: _bottomToolBar(),
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    ScreenAdaper.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("订单页面"),
      ),
      body: this._bodyWidget(),
    );
  }
}
