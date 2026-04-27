import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../services/ScreenAdaper.dart';
import '../../model/GHomeCarouselDataModel.dart';
import '../../widget/LoadingWidget.dart';
import '../../services/httptool.dart';
import '../../model/GHGuessLikeModel.dart';
import '../../model/GHHotGoodsModel.dart';
import 'package:transparent_image/transparent_image.dart';

/// 首页
class GHHomePage extends StatefulWidget {
  const GHHomePage({Key? key}) : super(key: key);

  _GHHomePageState createState() => _GHHomePageState();
}

class _GHHomePageState extends State<GHHomePage> with AutomaticKeepAliveClientMixin {
  /// 猜你喜欢
  List _getGuessLikeList = [];

  /// 轮播图模型数组
  List _carouselDataList = [];

  ///  热门推荐
  List _hotGoodsList = [];

  /// 轮播图当前页
  int _currentCarouselIndex = 0;

  /// 轮播图控制器
  late PageController _carouselController;

  /// 实现保持状态
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    _carouselController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _carouselController = PageController();

    /// 获取轮播图数据
    _getCarouselData();

    /// 猜你喜欢
    _getGuessLicktData();

    /// 热门商品
    _getHotGoodsData();
  }

  //获取轮播图数据
  void _getCarouselData() async {
    var url = "/classes/shopCarousel";
    await HttpRequest.request(url, method: 'GET').then((value) {
      var list = GHomeCarouselDataModel.fromJson(value).results ?? [];
      setState(() {
        this._carouselDataList = list;
      });
    });
  }

  //获取猜你喜欢的数据
  void _getGuessLicktData() async {
    var url = "/classes/shopGuessLike";
    await HttpRequest.request(url).then((value) {
      print(value);
      var list = GHGuessLikeModel.fromJson(value).results ?? [];
      setState(() {
        this._getGuessLikeList = list;
      });
    });
  }

  //获取热门商品的数据
  void _getHotGoodsData() async {
    var url = "/classes/shopHotGoods";
    await HttpRequest.request(url).then((value) {
      var list = GHHotGoodsModel.fromJson(value).results ?? [];
      setState(() {
        this._hotGoodsList = list;
      });
    });
  }

  /// 轮播图
  Widget _swiperWidget() {
    if (this._carouselDataList.length == 0) {
      return LoadingWidget();
    }
    return Stack(
      children: <Widget>[
        Container(
          height: ScreenAdaper.height(400),
          width: double.infinity,
          child: PageView.builder(
            controller: _carouselController,
            onPageChanged: (index) {
              setState(() {
                _currentCarouselIndex = index;
              });
            },
            itemCount: this._carouselDataList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {},
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: this._carouselDataList[index].url ?? "",
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                this._carouselDataList.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentCarouselIndex == index
                        ? Colors.white
                        : Colors.white54,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _superspike() {
    return Container(
      height: ScreenAdaper.height(320),
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Image.network(
            "https://q7.itc.cn/q_70/images03/20240927/e0cca33ed4ef428c9998fd0b4d48d3d7.jpeg",
            fit: BoxFit.fill),
      ),
    );
  }

  /// 封装公告标题组件
  Widget _titleWidget(text) {
    return Container(
      height: ScreenAdaper.height(32),
      margin: EdgeInsets.only(left: ScreenAdaper.width(20)),
      padding: EdgeInsets.only(left: ScreenAdaper.width(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
        color: Colors.orange,
        width: ScreenAdaper.width(10),
      ))),
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
      // child:
    );
  }

  Widget _hotGoodstWidget() {
    if (this._hotGoodsList.length == 0) {
      return LoadingWidget();
    }
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: this._hotGoodsList.map((value) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pushNamed(context, '/GHGoodsDetails', arguments: {
                  'id': '5eec49783521d4000606e7d4',
                });
              },
              child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
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
                                    style: TextStyle(fontSize: 10, color: Colors.red),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "${value.price}",
                                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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
                                style: TextStyle(color: Colors.black54, fontSize: 10),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )));
        }).toList(),
      ),
    );
  }

  Widget _boutique(String url) {
    return Container(
      width: (ScreenAdaper.getScreenWidth() - 55) / 4,
      height: 130,
      child: new FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: url,
      ),
    );
  }

  /// 热门商品
  Widget _guessLiketWidget() {
    if (this._getGuessLikeList.length == 0) {
      return LoadingWidget();
    }
    return Container(
      height: ScreenAdaper.height(220),
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (contxt, index) {
          GHGuessLikeItemModel itemModel = this._getGuessLikeList[index];
          return Column(
            children: <Widget>[
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pushNamed(context, '/GHGoodsDetails', arguments: {
                    'id': '5eec49783521d4000606e7d4',
                  });
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      height: ScreenAdaper.height(140),
                      width: ScreenAdaper.width(140),
                      margin: EdgeInsets.only(right: ScreenAdaper.width(21)),
                      child: new FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: itemModel.url ?? "",
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
                      height: ScreenAdaper.height(44),
                      child: Text(
                        "¥${itemModel.price}元",
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
        itemCount: this._getGuessLikeList.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.only(top: 0),
            children: <Widget>[
              /// 轮播图
              this._swiperWidget(),

              /// 超级秒杀
              this._superspike(),
              SizedBox(height: ScreenAdaper.height(20)),

              /// 猜你喜欢
              this._titleWidget("猜你喜欢"),

              /// 猜你喜欢
              this._guessLiketWidget(),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    _boutique("https://upload-images.jianshu.io/upload_images/1419035-84f72de1cfe0dc5e.jpg"),
                    SizedBox(
                      width: 5,
                    ),
                    _boutique("https://upload-images.jianshu.io/upload_images/1419035-6c2ca47d7cd45566.jpg"),
                    SizedBox(
                      width: 5,
                    ),
                    _boutique("https://upload-images.jianshu.io/upload_images/1419035-983a85c7b5a9a35a.jpg"),
                    SizedBox(
                      width: 5,
                    ),
                    _boutique("https://upload-images.jianshu.io/upload_images/1419035-216bcc1143e07d0a.jpg"),
                  ],
                ),
              ),
              SizedBox(height: ScreenAdaper.height(5)),

              /// 热门推荐
              this._titleWidget("热门推荐"),

              SizedBox(height: ScreenAdaper.height(10)),

              /// 热门推荐
              this._hotGoodstWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
