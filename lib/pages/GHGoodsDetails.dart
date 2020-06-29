import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';
import 'package:flutter/gestures.dart';
import '../services/httptool.dart';
import 'dart:convert';
import '../model/GHGoodDetailsModel.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../model/GHAddressModel.dart';
import '../widget/GHCountItemWidget.dart';
import '../widget/GHLoading.dart';

class GHGoodsDetails extends StatefulWidget {
  Map arguments;

  @override
  _GHGoodsDetailsState createState() => _GHGoodsDetailsState();

  GHGoodsDetails({Key key, this.arguments}) : super(key: key);
}

class _GHGoodsDetailsState extends State<GHGoodsDetails> {
  /// 滚动控制器
  ScrollController _scrollController = new ScrollController();

  /// 用户选择数量
  int _count = 1;

  Color _actionColor;

  /// 用户选择的规格型号
  String _seletecdStrings = "";

  /// 优惠券
  List coupons = [];

  /// 商品详情模型
  GHGoodDetailsModel _goodDetailsModel;

  /// 地址模型
  Results _addressModel;

  @override
  void initState() {
    super.initState();
    this._loadData();
    this._getAddressList();
    double height = ScreenAdaper.height(400);
    this._scrollController.addListener(() {});

    this._getSeletecdList();
  }

  /// 请求数据
  void _loadData() async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/" +
        "shopGoodsList/${widget.arguments["id"]}";
    await HttpRequest.request(url, method: 'GET').then((value) {
      var json = jsonEncode(value);
      GHGoodDetailsModel goodDetailsModel = GHGoodDetailsModel.fromJson(value);
      setState(() {
        this._goodDetailsModel = goodDetailsModel;
      });
    });
  }

  /// 请求地址
  void _getAddressList() async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/shopAddress";
    var c = Uri.encodeComponent('-createdAt');
    url = url + '?' + "order=" + c;

    HttpRequest.request(url, method: 'GET').then((res) {
      var list = new GHAddressModel.fromJson(res).results;
      setState(() {
        this._addressModel = list.first;
      });
    });
  }

  /// 加入到购物车
  void _addGood() async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/shopCartList";
    Map<String, dynamic> params = {
      "title": this._goodDetailsModel.title,
      "price": this._goodDetailsModel.price,
      "seletecdStrings": this._seletecdStrings,
      "count": this._count,
      "province": this._addressModel.province,
      "city": this._addressModel.city,
      "area": this._addressModel.area,
      "detailsAddress": this._addressModel.detailsAddress,
      "urls": this._goodDetailsModel.urls,
      "url": this._goodDetailsModel.url,
      "check": true,
      "goodId": this._goodDetailsModel.objectId,
    };
    HttpRequest.request(url, method: 'POST', params: params).then((value) {
      GHLoading.hideLoading(context);

      var objectId = value["objectId"];
      if (objectId != null) {
        print("加入购物车成功");
      } else {
        print("加入购物车失败");
      }
    });
  }

  List _seletecdList = [];

  @override
  void dispose() {
    super.dispose();
    this._scrollController.dispose();
  }

  List _services = [
    {"title": "可配送海外"},
    {"title": "京东发货&售后"},
    {"title": "7天无理由退货"},
    {"title": "京尊达"},
    {"title": "次日达"},
    {"title": "免举证换货"},
    {"title": "原厂维修"},
    {"title": "自提"}
  ];

  /// 构造筛选Map
  List _firstList = [
    {"id": "1", "title": "京东物流", "type": "1", "seletecd": "0"},
    {"id": "2", "title": "货到付款", "type": "2", "seletecd": "0"},
    {"id": "3", "title": "仅看有货", "type": "3", "seletecd": "0"},
    {"id": "4", "title": "京东国际", "type": "5", "seletecd": "0"}
  ];

  /// 构造筛选Map
  List _secondList = [
    {"id": "1", "title": "6-10", "type": "1", "seletecd": "0"},
    {"id": "2", "title": "10-26", "type": "1", "seletecd": "0"},
    {"id": "3", "title": "26-137", "type": "1", "seletecd": "0"}
  ];

  /// 构造筛选Map
  List _thirdList = [
    {"id": "1", "title": "32G", "type": "1", "seletecd": "1"},
    {"id": "2", "title": "64G", "type": "1", "seletecd": "0"},
    {"id": "3", "title": "128G", "type": "1", "seletecd": "0"},
    {"id": "1", "title": "256G", "type": "1", "seletecd": "0"},
  ];

  /// 网络运营商
  List _fourList = [
    {"id": "1", "title": "移动", "type": "1", "seletecd": "1"},
    {"id": "2", "title": "联通", "type": "1", "seletecd": "0"},
    {"id": "3", "title": "电信", "type": "1", "seletecd": "0"},
  ];

  /// 套餐
  List _fiveList = [
    {"id": "1", "title": "10G", "type": "1", "seletecd": "1"},
    {"id": "2", "title": "100G", "type": "1", "seletecd": "0"},
    {"id": "2", "title": "200G", "type": "1", "seletecd": "0"},
    {"id": "2", "title": "500G", "type": "1", "seletecd": "0"},
  ];

  /// 颜色
  List _sixList = [
    {"id": "1", "title": "红色", "type": "1", "seletecd": "1"},
    {"id": "2", "title": "黑色", "type": "1", "seletecd": "0"},
    {"id": "2", "title": "土豪金", "type": "1", "seletecd": "0"},
    {"id": "2", "title": "绿色", "type": "1", "seletecd": "0"},
  ];

  /// 广告
  Widget _superspike() {
    return Container(
      height: ScreenAdaper.height(80),
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Image.network(
            "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2453876778,4252200680&fm=26&gp=0.jpg",
            fit: BoxFit.fill),
      ),
    );
  }

  /// 轮播图
  Widget _swiperWidget() {
    return Container(
      width: double.infinity,
      child: Container(
        height: ScreenAdaper.height(400),
        child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {},
                child: Image.network(
                  "https://upload-images.jianshu.io/upload_images/1419035-8348d9e1439d81a7.jpg",
                  fit: BoxFit.fill,
                ),
              );
            },
            itemCount: 3,
            pagination: new SwiperPagination(),
            autoplay: true),
      ),
    );
  }

  /// 服务
  Widget _goodService() {
    return Container(
        color: Color.fromRGBO(253, 249, 210, 1),
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
              height: 24,
              width: 24,
              child: Image.asset(
                'images/serviceIcon.png',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
                child: Text(
              "为京东Apple产品用户提供无忧服务",
              style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(135, 102, 59, 1),
              ),
            ))
          ],
        ));
  }

  /// 商品标题
  Widget _goodTitle(GHGoodDetailsModel goodDetailsModel) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                width: ScreenAdaper.getScreenWidth(),
                child: Text.rich(TextSpan(
                  children: <InlineSpan>[
                    WidgetSpan(
                        child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      width: 40,
                      height: 18,
                      child: Text(
                        "自营",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )),
                    WidgetSpan(
                        child: Container(
                      width: 5,
                    )),
                    TextSpan(
                        text: goodDetailsModel.title.length > 0
                            ? "${goodDetailsModel.title}"
                            : "",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        )),
                  ],
                ))),
            Container(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                width: ScreenAdaper.getScreenWidth(),
                child: Text.rich(TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                        text: goodDetailsModel.description.length > 0
                            ? "${goodDetailsModel.description}"
                            : "",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
                        ),
                        children: [
                          WidgetSpan(
                            child: Container(width: 5, child: Text("")),
                          ),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('点击更多优惠');
                                },
                              text: '更多优惠!',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              )),
                        ]),
                  ],
                ))),
          ],
        ));
  }

  /// 规格子元素
  Widget _specificationItem(String title, String details, String imageName) {
    return Container(
        width: 100,
        child: Column(
          children: <Widget>[
            Container(
              height: 20,
              width: 20,
              child: Image.asset('images/${imageName}.png'),
            ),
            Container(
              padding: EdgeInsets.all(2),
              child: Text(
                title,
                style: TextStyle(fontSize: 12),
              ),
            ),
            Container(
                padding: EdgeInsets.all(2),
                child: Text(
                  details,
                  style: TextStyle(fontSize: 12),
                ))
          ],
        ));
  }

  Widget _goodspecification() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
                child: Text(
              "规格",
              style: TextStyle(fontSize: 12, color: Colors.black38),
            )),
            SizedBox(
              width: 10,
            ),
            _specificationItem("上市时间", "2020年6月", "goPublic"),
            _specificationItem("屏幕尺寸", "5.7英寸", "screen"),
            _specificationItem("厚度", "0.2mm", "thickness"),
          ],
        ));
  }

  /// 优惠券
  Widget _goodCoupon(GHGoodDetailsModel detailsModel) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
                child: Text(
              "领券",
              style: TextStyle(fontSize: 12, color: Colors.black38),
            )),
            SizedBox(
              width: 10,
            ),
            Container(
              //topTitles.asMap().keys.map((f)=>
              child: Row(
                children: detailsModel.coupons.asMap().keys.map((f) {
                  /// 处理text
                  String coupon = "";
                  String text = detailsModel.coupons[f];
                  if (text == "1") {
                    coupon = "满1000减50";
                  } else if (text == "2") {
                    coupon = "满2000减100";
                  } else {
                    coupon = "满3000减200";
                  }
                  return Row(
                    children: <Widget>[
                      Container(
                        color: Colors.red,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          coupon,
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  );
                }).toList(),
              ),
            )
          ],
        ));
  }

  Widget _romotionItem(title, details) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.red, width: 1)),
            child: Text(
              title,
              style: TextStyle(fontSize: 12, color: Colors.red),
            )),
        SizedBox(
          width: 10,
        ),
        Container(
          child: Text(details),
        )
      ],
    ));
  }

  /// 促销
  Widget _goodPromotion() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
                child: Text(
              "促销",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black38,
              ),
            )),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _romotionItem("换购", "买一件可优惠换购热销商品"),
                SizedBox(
                  height: 5,
                ),
                _romotionItem("赠品", "Mac推荐卡"),
                SizedBox(
                  height: 5,
                ),
                _romotionItem("优惠套装", "该商品共有11个套装"),
              ],
            )
          ],
        ));
  }

  /// 已选
  Widget _goodSelected(GHGoodDetailsModel goodDetailsModel) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
                child: Text(
              "已选",
              style: TextStyle(fontSize: 12, color: Colors.black38),
            )),
            SizedBox(
              width: 10,
            ),
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    this._showBottomSheet(goodDetailsModel);
                  },
                  child: Container(
                    child: Text(
                        this._seletecdStrings.length > 0
                            ? this._seletecdStrings
                            : "请选择",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                    child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.help_outline,
                        size: 12,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                        child: Text("可选服务 ",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            )))
                  ],
                ))
              ],
            ))
          ],
        ));
  }

  /// 地址
  Widget _goodAddress() {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pushNamed(context, '/GHAddressList');
        },
        child: Container(
            width: ScreenAdaper.getScreenWidth(),
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Container(
                    width: 30,
                    child: Text(
                      "送至",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black38,
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                    width: ScreenAdaper.getScreenWidth() - 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            child: Row(
                          children: <Widget>[
                            Container(
                              child: Icon(
                                Icons.location_on,
                                size: 12,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              child: Text(
                                this._addressModel.province +
                                    this._addressModel.city +
                                    this._addressModel.area +
                                    this._addressModel.detailsAddress,
                              ),
                            )
                          ],
                        )),
                        Container(
                          child: RichText(
                              text: TextSpan(
                                  text: "11:10",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                TextSpan(
                                    text:
                                        "前下单,预计今天(06月26日)送达,受道路封闭影响,您的订单可能会有所延迟,我们将尽快为您送达,请您耐心等待",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ])),
                        )
                      ],
                    ))
              ],
            )));
  }

  /// 门店列表
  Widget _goodShops() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      child: Row(
                    children: <Widget>[
                      Container(
                        width: 5,
                        height: 16,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text("线下体验店"),
                      ),
                    ],
                  )),
                  Container(
                      child: Row(
                    children: <Widget>[
                      Container(
                        child: Text("查看全部门店"),
                      ),
                      Container(
                        child: Icon(
                          Icons.arrow_right,
                          size: 20,
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
            Container(
              child: Text(
                this._addressModel.province +
                    this._addressModel.city +
                    this._addressModel.area +
                    "1号店",
              ),
            ),
            Container(
                child: Wrap(
              spacing: 0,
              runSpacing: 0,
              children: this._services.map((value) {
                return Container(
                  height: 30,
                  child: Chip(
                    labelPadding: EdgeInsets.only(left: 0),
                    backgroundColor: Colors.transparent,
                    avatar: Icon(
                      Icons.check_circle_outline,
                      size: 18,
                    ),
                    label: Text(
                      value["title"],
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                );
              }).toList(),
            ))
          ],
        ));
  }

  /// 评价
  Widget _goodEvaluation() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                child: Row(
              children: <Widget>[
                Container(
                  width: 5,
                  height: 16,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Text("14万"),
                )
              ],
            )),
            Container(
                child: Row(
              children: <Widget>[
                Container(
                  child: Text("好评度93%"),
                ),
                Container(
                  child: Icon(Icons.arrow_right),
                ),
              ],
            )),
          ],
        ));
  }

  /// 评价列表子项
  Widget _evaluationItem() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  height: 30,
                  width: 30,
                  child: CircleAvatar(
                    radius: 36.0,
                    backgroundImage: AssetImage(
                      'images/logo.png',
                    ),
                  ),
                ),
                Container(
                  child: Text("用户的名字"),
                ),
                Container(
                  child: Icon(Icons.home),
                ),
              ],
            ),
          ),
          Container(
            width: ScreenAdaper.getScreenWidth() - 20,
            child: Text(
              "人丑家穷还早衰家里蹲8年今年25 嗯呢 谢了人丑家穷还早衰家里蹲8年今年25 嗯呢 谢了人丑家穷还早衰家里蹲8年今年25 嗯呢 谢了",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            color: Colors.black,
            width: ScreenAdaper.getScreenWidth(),
            height: (ScreenAdaper.getScreenWidth() - 50) / 4,
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
              itemBuilder: (context, index) {
                return Container(
                  color: index % 2 == 0 ? Colors.red : Colors.orange,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  /// 评价列表
  Widget _goodEvaluationList() {
    return Container(
      child: Column(
        children: <Widget>[
          _evaluationItem(),
        ],
      ),
    );
  }

  /// 上方区域
  Widget _goodsDetails(GHGoodDetailsModel goodDetailsModel) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
        child: ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(
          top: 0, bottom: ScreenAdaper.height(80) + bottomPadding),
      children: <Widget>[
        this._superspike(),
        this._goodInfo(goodDetailsModel),
        this._goodTitle(goodDetailsModel),
        this._goodService(),
        this._goodspecification(),
        Divider(),
        this._goodCoupon(goodDetailsModel),
        Divider(),
        this._goodPromotion(),
        Container(
          height: 10,
          color: Color.fromRGBO(245, 245, 245, 1),
        ),
        this._goodSelected(goodDetailsModel),
        this._goodAddress(),
        Divider(),
        this._goodShops(),
        Container(
          height: 10,
          color: Color.fromRGBO(245, 245, 245, 1),
        ),
      ],
    ));
  }

  /// 获取用户选中
  void _getSeletecdList() {
    List seletecdList = [];
    this._firstList.forEach((element) {
      if (element["seletecd"] == "1") {
        seletecdList.add(element);
      }
    });

    this._thirdList.forEach((element) {
      if (element["seletecd"] == "1") {
        seletecdList.add(element);
      }
    });

    this._fourList.forEach((element) {
      if (element["seletecd"] == "1") {
        seletecdList.add(element);
      }
    });

    this._fiveList.forEach((element) {
      if (element["seletecd"] == "1") {
        seletecdList.add(element);
      }
    });

    this._sixList.forEach((element) {
      if (element["seletecd"] == "1") {
        seletecdList.add(element);
      }
    });
    this._seletecdList = seletecdList;

    List<String> _seletecdStrings = [];
    if (this._seletecdList.length > 0) {
      this._seletecdList.forEach((element) {
        _seletecdStrings.add(element["title"]);
      });
      setState(() {
        this._seletecdStrings = _seletecdStrings.toString();
      });
    }
  }

  /// 侧滑筛选子项
  Widget _sideItem(list, setBottomState, [seletecdType]) {
    /// 单选 多选 默认多选
    bool _seletecdType = seletecdType;

    /// 处理数组返回数量
    List actionList = [];
    if (list.length > 6) {
      for (var i = 0; i < 6; i++) {
        Map map = list[i];
        actionList.add(map);
      }
    }
    List temp = [];

    temp = list;

    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Wrap(
        spacing: 10,
        runSpacing: 5,
        children: temp.asMap().keys.map<Widget>((f) {
          Map map = temp[f];
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setBottomState(() {
                  if (_seletecdType == true) {
                    /// 单选
                    String sel = map["seletecd"];
                    if (sel == "1") {
                      map["seletecd"] = "0";
                    } else {
                      list.forEach((element) {
                        element["seletecd"] = "0";
                      });
                      map["seletecd"] = "1";
                    }
                  } else {
                    /// 多选
                    String sel = map["seletecd"];
                    if (sel == "0") {
                      map["seletecd"] = "1";
                    } else {
                      map["seletecd"] = "0";
                    }
                  }
                });
                this._getSeletecdList();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      width: 0.5,
                      color: map["seletecd"] == "0"
                          ? Colors.transparent
                          : Colors.red,
                    )),
                alignment: Alignment.center,
                height: 36,
                width: 80,
                child: Chip(
                  backgroundColor: map["seletecd"] == "0"
                      ? Color.fromRGBO(240, 240, 240, 1)
                      : Color.fromRGBO(245, 245, 245, 0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  label: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "#####",
                            style: TextStyle(
                                color: Colors.transparent, fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${map["title"]}",
                          style: TextStyle(
                              fontSize: 12,
                              color: map["seletecd"] == "1"
                                  ? Colors.red
                                  : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        }).toList(),
      ),
    );
  }

  /// 底部规格选择器子项
  Widget _bottomSpecificationItem(title, list, setBottomState, seletecdType) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              title,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: this._sideItem(list, setBottomState, seletecdType),
          ),
        ],
      ),
    );
  }

  /// 规格选择器
  void _showBottomSheet(GHGoodDetailsModel goodDetailsModel) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setBottomState) {
            return Container(
              height: 500,
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 120),
                    height: 500 - 20 - ScreenAdaper.height(80) - 10,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              this._bottomSpecificationItem(
                                  "容量", this._thirdList, setBottomState, true),
                              this._bottomSpecificationItem(
                                  "网络", this._fourList, setBottomState, true),
                              this._bottomSpecificationItem(
                                  "容量", this._fiveList, setBottomState, true),
                              this._bottomSpecificationItem(
                                  "颜色", this._sixList, setBottomState, true),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          "数量",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      GHCountItemWidger(
                                        addClick: (value) {
                                          setState(() {
                                            this._count = value;
                                          });
                                        },
                                        subClick: (value) {
                                          setState(() {
                                            this._count = value;
                                          });
                                        },
                                        count: this._count,
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      height: ScreenAdaper.height(80),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                this._getSeletecdList();
                                this._addGood();
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/',arguments: {
                                  "index":2,
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: ScreenAdaper.getScreenWidth(),
                                height: double.infinity,
                                color: Colors.red,
                                child: Text(
                                  "确 定",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ))
                        ],
                      )),
                  Positioned(
                      top: 0,
                      width: ScreenAdaper.getScreenWidth(),
                      height: 120,
                      child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(Icons.close),
                                  )),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                        width: ScreenAdaper.height(110),
                                        height: ScreenAdaper.height(110),
                                        child: Image.network(
                                          goodDetailsModel.url,
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            goodDetailsModel.title,
                                          ),
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                              )
                            ],
                          ))),
                ],
              ),
            );
          });
        });
  }

  /// 底部工具条
  Widget _bottomToolBar(GHGoodDetailsModel goodDetailsModel) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Positioned(
        bottom: 0,
        width: ScreenAdaper.getScreenWidth(),
        height: ScreenAdaper.height(80) + bottomPadding,
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: _iconWidget('images/customerService.png', "联系客服"),
                    ),
                    _iconWidget('images/shop.png', "店铺"),
                    _iconWidget('images/shoppingCart.png', "购物车"),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      this._showBottomSheet(goodDetailsModel);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: ScreenAdaper.height(80) - 10,
                      color: Colors.red,
                      child: Text(
                        "加入购物车",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      this._showBottomSheet(goodDetailsModel);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: ScreenAdaper.height(80) - 10,
                      color: Colors.orange,
                      child: Text(
                        "立即购买",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  )),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                width: 1,
                color: Colors.black12,
              ))),
        ));
  }

  Widget _iconWidget(imagePath, text) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              height: 20,
              width: 20,
              child: Image.asset(
                imagePath,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ));
  }

  /// 商品基本信息
  Widget _goodRightItem() {
    return Container(
        child: Row(
      children: <Widget>[
        _iconWidget('images/price.png', "降价通知"),
        _iconWidget('images/collect.png', "收藏"),
      ],
    ));
  }

  /// 商品基本信息
  Widget _goodInfo(GHGoodDetailsModel goodDetailsModel) {
    return Container(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: RichText(
                  text: TextSpan(
                      text: "¥",
                      style: TextStyle(color: Colors.red, fontSize: 10),
                      children: [
                    TextSpan(
                        text: "${goodDetailsModel?.price}",
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
            this._goodRightItem(),
          ],
        ));
  }

  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        EasyRefresh(
          onRefresh: () async {},
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(),
              SliverAppBar(
                pinned: true,
                brightness: Brightness.light,
                expandedHeight: 200,
                title: Text("商品详情"),
                flexibleSpace: FlexibleSpaceBar(
                  background: this._swiperWidget(),
                ),
              ),
              SliverToBoxAdapter(
                child: this._goodDetailsModel != null
                    ? Container(
                        /// 上方区域
                        child: this._goodsDetails(this._goodDetailsModel),
                      )
                    : Text(''),
              ),
            ],
          ),
        ),
        this._bottomToolBar(this._goodDetailsModel),
      ],
    ));
  }
}
