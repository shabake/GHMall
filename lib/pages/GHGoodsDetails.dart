import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';
import 'package:flutter/gestures.dart';
import '../services/httptool.dart';
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

  Color _actionColor;

  double _changeHeight = 0;

  @override
  void initState() {
    super.initState();
    print(widget.arguments["id"]);
    this._loadData();
    double height = ScreenAdaper.height(400);
    this._scrollController.addListener(() {
      double _opacity = this._scrollController.offset / height > 1.0
          ? 1.0
          : this._scrollController.offset / height;
      print(this._scrollController.offset);
      setState(() {
        this._changeHeight = -this._scrollController.offset;
      });
    });
  }

  /// 请求数据
  void _loadData() async {

    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/" +
        "shopGoodsList/${widget.arguments["id"]}";

    await HttpRequest.request(url, method: 'GET').then((value) {
      print(value);
    });
  }

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
  Widget _goodTitle() {
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
                        text:
                            '有线充电款AirPodrPods抢券电有线充电有线充s抢券低至999元有线充电有线充电有线充电有线充电有线充电',
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
                        text: '有线充电款AirPods抢券低至999元有线充电有线充电有线充电有线充电有线充电',
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
  Widget _specificationItem() {
    return Container(
        width: 100,
        child: Column(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.home,
                size: 22,
              ),
            ),
            Container(
              padding: EdgeInsets.all(2),
              child: Text(
                "上市时间",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Container(
                padding: EdgeInsets.all(2),
                child: Text(
                  "2020年1月",
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
            _specificationItem(),
            _specificationItem(),
            _specificationItem(),
          ],
        ));
  }

  /// 优惠券
  Widget _goodCoupon() {
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
              child: Row(
                children: <Widget>[
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "满500减50",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "满1000减250",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
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
  Widget _goodSelected() {
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
                Container(
                  child: Text("64GB 移动 双卡双待，每月120G流量套餐",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                    child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.home,
                        size: 12,
                      ),
                    ),
                    Container(
                        child: Text("就可以快速实现图文混排的需求，并且可以看出 ",
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
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Container(
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
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.home,
                            size: 12,
                          ),
                        ),
                        Container(
                          child: Text("就可以快速实现图文混排的需"),
                        )
                      ],
                    )),
                    Container(
                      child: Text("就可以快速实现图文混排的需求，并且可以看出"),
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
              child: Text("就可以快速实现图文混排的需求，并且可以看出"),
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
  Widget _goodsDetails() {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
        child: ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(
          top: 0, bottom: ScreenAdaper.height(80) + bottomPadding),
      children: <Widget>[
        this._superspike(),
        this._goodInfo(),
        this._goodTitle(),
        this._goodService(),
        this._goodspecification(),
        Divider(),
        this._goodCoupon(),
        Divider(),
        this._goodPromotion(),
        Container(
          height: 10,
          color: Color.fromRGBO(245, 245, 245, 1),
        ),
        this._goodSelected(),
        this._goodAddress(),
        Divider(),
        this._goodShops(),
        Container(
          height: 10,
          color: Color.fromRGBO(245, 245, 245, 1),
        ),
        this._goodEvaluation(),
        this._goodEvaluationList(),
      ],
    ));
  }

  /// 底部工具条
  Widget _bottomToolBar() {
    final double topPadding = MediaQuery.of(context).padding.top;
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
                child: Container(
                  alignment: Alignment.center,
                  height: ScreenAdaper.height(80) - 10,
                  color: Colors.red,
                  child: Text(
                    "加入购物车",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  height: ScreenAdaper.height(80) - 10,
                  color: Colors.orange,
                  child: Text(
                    "立即购买",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
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
  Widget _goodInfo() {
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
                        text: "5999",
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
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            body: Stack(
          children: <Widget>[
            CustomScrollView(
              controller: this._scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  title: Container(
                    child: Text(
                      "商品详情",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //标题居中
                  centerTitle: true,
                  //展开高度200
                  expandedHeight: ScreenAdaper.height(400),
                  //不随着滑动隐藏标题
                  floating: true,
                  //固定在顶部
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Container(
                        child: this._swiperWidget(),
                      )),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    /// 上方区域
                    child: this._goodsDetails(),
                  ),
                ),
              ],
            ),

            /// 底部工具条
            this._bottomToolBar(),
          ],
        )));
  }
}
