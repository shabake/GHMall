import 'package:flutter/material.dart';
import '../services/httptool.dart';
import '../model/GHAddressModel.dart';
import '../services/ScreenAdaper.dart';
import '../widget/LoadingWidget.dart';
import 'package:transparent_image/transparent_image.dart';
import '../model/GHGoodDetailsModel.dart';
import '../widget/GHRichTextPriceWidget.dart';

/// 订单确认页
class GHCheckOut extends StatefulWidget {
  final Map arguments;

  @override
  GHCheckOut({Key key, this.arguments}) : super(key: key);

  _GHCheckOutState createState() => _GHCheckOutState();
}

class _GHCheckOutState extends State<GHCheckOut> {
  List _goodList = [];

  double _total = 0;
  Results results;
  /// 获取地址
  void _getAddressList() async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/shopAddress";
    await HttpRequest.request(url, method: 'GET').then((res) {
      Results firstModel = new GHAddressModel.fromJson(res).results.first;
      setState(() {
        results = firstModel;
      });
    });
  }

  /// 获取订单详情
  void _getOrderDetails(String id) async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/shopOrderList/${id}";
    await HttpRequest.request(url, method: 'GET').then((res) {
      List _tempgoodList = res["goodList"];
      double _temptotal = res["total"];

      List goodList = [];
      for (var i = 0; i < _tempgoodList.length; i++) {
        GHGoodDetailsModel goodDetailsModel =
            new GHGoodDetailsModel.fromJson(_tempgoodList[i]);
        goodList.add(goodDetailsModel);
      }
      setState(() {
        this._goodList = goodList;
        this._total = _temptotal;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    this._getAddressList();
    this._getOrderDetails(widget.arguments["id"]);
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

  /// 商品子项
  Widget _goodItem(GHGoodDetailsModel goodDetailsModel) {
    return Container(
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
            height: 130,
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/GHGoodsDetails', arguments: {
//                      'id': goodDetailsModel.goodId,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            goodDetailsModel.title,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.black12,
                                          child: Text(
                                            goodDetailsModel.seletecdStrings,
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
                                                        "${goodDetailsModel.price}",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text: ".00",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ])),
                                        ),
                                        Container(
                                          child: Text(
                                            "x ${goodDetailsModel.count}",
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
                ))));
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
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: this._goodList.length,
            itemBuilder: (BuildContext context, index) {
              return this._goodItem(this._goodList[index]);
            }),
        Container(
          height: 10,
          color: Color.fromRGBO(245, 245, 245, 1),
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
                        "￥ ${this._total}",
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
                      child: Text("优惠券"),
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
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
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
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: GHRichTextPriceWidget(this._total + 10),
                  ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.center,
                width: 100,
                height: 40,
                color: Colors.red,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pushNamed(context, '/OnlinePayments' ,arguments: {
                      "id":widget.arguments["id"],
                    });
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
        title: Text("订单详情"),
      ),
      body: this._bodyWidget(),
    );
  }
}
