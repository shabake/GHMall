import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../widget/LoadingWidget.dart';
import '../../services/httptool.dart';
import '../../model/GHCategoryModel.dart';
import 'dart:convert';
import 'package:transparent_image/transparent_image.dart';
import '../../widget/GHCustomAppbar.dart';
import '../../services/GHToast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:barcode_scan/barcode_scan.dart';

/// 分类
class GHCategoryPage extends StatefulWidget {
  GHCategoryPage({Key key}) : super(key: key);

  _GHCategoryPageState createState() => _GHCategoryPageState();
}

class _GHCategoryPageState extends State<GHCategoryPage>
    with AutomaticKeepAliveClientMixin {

  /// 左侧选择序号
  int _selectIndex = 0;

  List _leftCateList = [];

  List _urls = [];

  String _firstTitle;

  /// 第一组商品
  List _firstGoods = [];

  String _secondTitle;

  /// 第二组商品
  List _secondGoods = [];

  final picker = ImagePicker();


  @override

  /// 保持页面状态
  bool get wantKeepAlive => true;

  void initState() {
    super.initState();
    _getLeftCateData();
  }

  /// 获取左侧分类
  _getLeftCateData() async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/shopCategory";
    await HttpRequest.request(url, method: 'GET').then((value) {
      var list = new GHCategoryModel.fromJson(value).results;
      setState(() {
        this._leftCateList = list;
      });
    });
    _getRightCateData(this._leftCateList[0].type);
  }

  /// 获取右侧分类
  _getRightCateData(type) async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/shopSecondCategory";
    //where={"type":"1"}
    /// urlEncode编码
    var actionString = {"type": type};
    var jsonText = jsonEncode(actionString);
    var parameter = Uri.encodeFull(jsonText);

    /// 得到最终url
    url = url + '?' + "where=" + parameter;

    await HttpRequest.request(url, method: 'GET').then((value) {
      print(value);
      List results = value["results"];
      if (results.isEmpty && results.length == 0) {
        GHToast.showTost("获取数据失败,请检查服务器");
        return;
      }
      Map urlMap = results.first["urls"];
      List urls = urlMap["url"];
      List firstGoods = [];
      List secondGoods = [];
      List firstgoods = results.first["firstDict"]["goods"];
      List secondgoods = results.first["secondDict"]["goods"];
      String firstTitle = results.first["firstDict"]["title"];
      String secondTitle = results.first["secondDict"]["title"];

      for (var dict in firstgoods) {
        var item = new GHCategoryItemModel.fromJson(dict);
        firstGoods.add(item);
      }

      for (var dict in secondgoods) {
        var item = new GHCategoryItemModel.fromJson(dict);
        secondGoods.add(item);
      }
      setState(() {
        this._urls = urls;
        this._firstTitle = firstTitle;
        this._firstGoods = firstGoods;
        this._secondTitle = secondTitle;
        this._secondGoods = secondGoods;
      });
    });
  }

  /// 左侧列表Widget
  Widget _leftCateWidget(leftWidth) {
    if (this._leftCateList.length == 0) {
      return LoadingWidget();
    }
    return Container(
      width: leftWidth,
      height: double.infinity,
      child: ListView.builder(
        itemCount: this._leftCateList.length,
        itemBuilder: (context, index) {
          GHCategoryItemModel itemModel = this._leftCateList[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    setState(() {
                      this._selectIndex = index;
                      this._getRightCateData(this._leftCateList[index].type);
                    });
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: ScreenAdaper.height(80),
                        color: this._selectIndex != index
                            ? Color.fromRGBO(233, 233, 233, 0.2)
                            : Colors.white,
                        child: Text(
                          "${itemModel.categoryName}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: this._selectIndex != index ? 14 : 16,
                            fontWeight: this._selectIndex != index
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: ScreenAdaper.height(80),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 18,
                              width: 3,
                              color: this._selectIndex != index
                                  ? Colors.transparent
                                  : Colors.red,
                            )
                          ],
                        ),
                      )
                    ],
                  )),
              Divider(height: 0.5),
            ],
          );
        },
      ),
    );
  }

  /// 轮播图
  Widget _swiperWidget() {
    if (this._urls.length == 0) {
      return LoadingWidget();
    }
    return Container(
      padding: EdgeInsets.all(10),
      height: 150,
      child: Swiper(
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {},
              child: Image.network(
                this._urls[index],
                // pic
                fit: BoxFit.cover,
              ),
            );
          },
          itemCount: this._urls.length,
          pagination: new SwiperPagination(),
          autoplay: false),
    );
  }

  Widget _categoryItem(
      GHCategoryItemModel categoryItemModel, BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/GHGoodsList');
        },
        child: Container(
          width: (ScreenAdaper.getScreenWidth() -
                  ScreenAdaper.getScreenWidth() / 4 -
                  40) /
              3.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 80,
                padding: EdgeInsets.all(10),
                child: new FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: categoryItemModel.url,
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  categoryItemModel.categoryName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              )
            ],
          ),
        ));
  }

  Widget _firstWidget(String title, List list, BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: list.map((value) {
              return _categoryItem(value, context);
            }).toList(),
          ),
        )
      ],
    );
  }

  /// 右侧分类Widget
  Widget _rightCateWidget(rightItemWidth, rightItemHeight, context) {
    return Container(
      height: ScreenAdaper.getScreenHeight(),
      width: ScreenAdaper.getScreenWidth() / 4 * 3.0,
      child: ListView(
        children: <Widget>[
          _swiperWidget(),
          this._firstTitle == null
              ? Text("")
              : _firstWidget(this._firstTitle, this._firstGoods, context),
          this._secondTitle == null
              ? Text("")
              : _firstWidget(this._secondTitle, this._secondGoods, context),
        ],
      ),
    );
  }

  /// 相机拍照
  void _takePhoto() async {
//    final pickedFile = await picker.getImage(source: ImageSource.camera);
    /// 开始二维码扫描
    var result = await BarcodeScanner.scan();
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    final double topPadding = MediaQuery.of(context).padding.top;

    var leftWidth = ScreenAdaper.getScreenWidth() / 4;
    var rightItemWidth =
        (ScreenAdaper.getScreenWidth() - leftWidth - 20 - 20) / 3;
    rightItemWidth = ScreenAdaper.width(rightItemWidth);
    var rightItemHeight = rightItemWidth + ScreenAdaper.height(28);

    return Scaffold(
      appBar: GHCustomAppbar(
        contentHeight: topPadding + 20,
        leadingWidget: Container(
          padding: EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: (){
              this._takePhoto();
            },
            child: Icon(
              Icons.center_focus_weak,
              color: Colors.black54,
            ),
          )
        ),
        trailingWidget: IconButton(icon: Icon(Icons.inbox), onPressed: null),
        titleWidget: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/search');
          },
          child: Container(
            width: ScreenAdaper.getScreenWidth() - 100,
            height: ScreenAdaper.height(50),
            padding: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Colors.black12,
                ),
                Text(
                  "618秒杀",
                  style: TextStyle(fontSize: 14, color: Colors.black12),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: ScreenAdaper.getScreenWidth(),
        height: ScreenAdaper.getScreenHeight(),
        child: Row(
          children: <Widget>[
            _leftCateWidget(leftWidth),
            Expanded(
              child: _rightCateWidget(rightItemWidth, rightItemHeight, context),
            )
          ],
        ),
      ),
    );
  }
}
