import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';
import '../services/httptool.dart';
import '../widget/GHCustomAppbar.dart';
import '../model/GHGoodsModel.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'dart:convert';
import '../widget/GHLoading.dart';

/// 商品列表
class GHGoodsList extends StatefulWidget {
  Map arguments;

  GHGoodsList({Key key, this.arguments}) : super(key: key);

  _GHGoodsListState createState() => _GHGoodsListState();
}

class _GHGoodsListState extends State<GHGoodsList> {
  /// 最低价
  TextEditingController _minPriceEditingController =
      new TextEditingController();

  /// 最高价
  TextEditingController _maxPriceEditingController =
      new TextEditingController();

  //Scaffold key 用于打开侧滑筛选菜单
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //用于上拉分页 listview 的控制器
  EasyRefreshController _controller = EasyRefreshController();

  /// 分页
  int _skip = 0;

  /// 销量最高
  String _isSales = "";

  /// 销量最高
  String _isPrice = "";

  /// 用户点击价格的次数
  int _count = 0;

  /// _flag
  bool _flag = true;

  /// 所有的商品数据
  List _list = [];

  bool seletect = false;

  /// 构造筛选Map
  List _filterList = [
    {
      "id": "1",
      "title": "综合",
      "fileds": "all",
      "sort": "1",
      "seletecd": "1",
    },
    {
      "id": "2",
      "title": "销量",
      "fileds": 'saleCount',
      "sort": "1",
      "seletecd": "0"
    },
    {"id": "3", "title": "价格", "fileds": 'price', "sort": "1", "seletecd": "0"},
    {"id": "4", "title": "筛选", "seletecd": "0"}
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
    {"id": "1", "title": "得力", "type": "1", "seletecd": "0"},
    {"id": "2", "title": "广博", "type": "1", "seletecd": "0"},
    {"id": "3", "title": "TANGO", "type": "1", "seletecd": "0"},
    {"id": "1", "title": "晨光", "type": "1", "seletecd": "0"},
    {"id": "2", "title": "齐心", "type": "1", "seletecd": "0"},
    {"id": "3", "title": "3M", "type": "1", "seletecd": "0"},
  ];

  /// 网络运营商
  List _fourList = [
    {"id": "1", "title": "移动", "type": "1", "seletecd": "0"},
    {"id": "2", "title": "联通", "type": "1", "seletecd": "0"},
    {"id": "3", "title": "电信", "type": "1", "seletecd": "0"},
  ];

  List _seletecdList = [];

  //二级导航选中判断
  int _selectHeaderId = 1;

  int _countLength = 10;

  /// 请求数据
  void _loadData() async {
    if (this._count == 0) {
      this._isPrice = "";
    } else if (this._count == 1) {
      this._isPrice = "price";
    } else {
      this._isPrice = "-price";
    }

    /// 默认最小值
    int minPrice = 0;
    if (this._minPriceEditingController.text.length > 0) {
      minPrice = int.parse(this._minPriceEditingController.text);
    }

    /// 默认最大值
    int maxPrice = 2147483647;
    if (this._maxPriceEditingController.text.length > 0) {
      maxPrice = int.parse(this._maxPriceEditingController.text);
    }

    var and = "\$and";
    var gt = "\$gt";
    var lt = "\$lt";
    var icn = "\$in";

    Map wherePrice = {
      and: [
        {
          "price": {gt: minPrice}
        },
        {
          "price": {lt: maxPrice}
        },
      ]
    };

    List types = [];

    this._seletecdList.forEach((element) {
      if (element["seletecd"] == "1") {
        types.add(element["type"]);
      }
    });

    if (types.length > 0) {
      Map whereType = {
        "service": {icn: types},
      };
      wherePrice.addAll(whereType);
    }

    var jsonWherePrice = jsonEncode(wherePrice);
    var parameterWherePrice = Uri.encodeFull(jsonWherePrice);

    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/" +
        "shopGoodsList?limit=10&&skip=${this._skip}&&order=${this._isSales},${this._isPrice}&&where=${parameterWherePrice}";

    print(url);
    await HttpRequest.request(url, method: 'GET').then((value) {
      List _goods = GHGoodsModel.fromJson(value).results;
      List _items = [];
      for (var item in _goods) {
        _items.add(item);
      }

      setState(() {
        this._list.addAll(_items);
      });

      if (_goods.length == 10) {
        this._controller.finishRefresh();
      }

      if (_goods.length < 10) {
        this._controller.finishLoad(success: true, noMore: true);
      }
      GHLoading.hideLoading(context);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  /// 改变筛选菜单状态
  _changeFilterStatus(index, seletecd) {
    Map map = this._filterList[index];
    map["seletecd"] = seletecd;
    setState(() {});
  }

  /// 重置所有数据
  _reastData() {
    this._seletecdList.forEach((element) {
      setState(() {
        element["seletecd"] = "0";
      });
    });

    this._changeFilterStatus(3, "0");
    this._minPriceEditingController.text = "";
    this._maxPriceEditingController.text = "";
  }

  /// 点击确定
  _clickSure() {
    if ((this._seletecdList != null && this._seletecdList.length > 0) ||
        this._maxPriceEditingController.text.length > 0 ||
        this._minPriceEditingController.text.length > 0) {
      _changeFilterStatus(3, "1");
    }
    this._controller.callRefresh();
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
    this._seletecdList = seletecdList;

    print(seletecdList);
  }

  /// 侧滑每行的标题
  Widget _sideSectionTitle(String title, [List list]) {
    List array = [];
    List test = [];

    if (list != null) {
      list.forEach((element) {
        if (element["seletecd"] == "1") {
          array.add(element["title"]);
          test.join(element["title"]);
        }
      });
    }
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 200,
                  child: Text(
                    array.length > 0 ? array.toString() : "",
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ),
                list != null && list.length > 6
                    ? Container(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              this.seletect = !this.seletect;
                            });
                          },
                          child: this.seletect == true
                              ? Icon(Icons.arrow_drop_down)
                              : Icon(Icons.arrow_drop_up),
                        ),
                      )
                    : Text(""),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 侧滑筛选子项
  Widget _sideItem(list, [seletecdType]) {
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
    if (this.seletect && list.length > 6) {
      temp = actionList;
    } else {
      temp = list;
    }
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Wrap(
        spacing: 10,
        runSpacing: 5,
        children: temp.asMap().keys.map<Widget>((f) {
          Map map = temp[f];
          return GestureDetector(
              onTap: () {
                setState(() {
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
                width: 103,
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
                            style: TextStyle(color: Colors.transparent),
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

  Widget _sideTextItem([textEditingController, String hintText]) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 125,
      decoration: BoxDecoration(
        color: Color.fromRGBO(240, 240, 240, 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextField(
        controller: textEditingController,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 0, top: 0),
            counterText: '',
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.black38,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }

  /// 侧滑价格
  Widget _sidePriceItem() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _sideTextItem(this._minPriceEditingController, "最低价"),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 1,
            width: 10,
            color: Colors.black,
          ),
          SizedBox(
            width: 10,
          ),
          _sideTextItem(this._maxPriceEditingController, "最高价"),
        ],
      ),
    );
  }

  /// 侧滑筛选
  Widget _sideFilter() {
    return Container(
        child: Stack(
      children: <Widget>[
        Positioned(
          bottom: 34,
          height: ScreenAdaper.height(80),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
              width: 1,
              color: Colors.black12,
            ))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _reastData();
                  },
                  child: Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      width: 175,
                      child: Text(
                        "重置",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )),
                ),
                GestureDetector(
                    onTap: () {
                      this._clickSure();
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 175,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: Text(
                        "确定",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ))
              ],
            ),
          ),
        ),
        Container(
          height: ScreenAdaper.getScreenHeight() - ScreenAdaper.height(80) - 30,
          child: ListView(
            children: <Widget>[
              Container(
                  child: Column(
                children: <Widget>[
                  _sideSectionTitle("服务/折扣", this._firstList),
                  _sideItem(this._firstList),
                ],
              )),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _sideSectionTitle("价格区间"),
                    _sidePriceItem(),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    _sideSectionTitle("品牌", this._thirdList),
                    _sideItem(this._thirdList),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    _sideSectionTitle("运营商", this._fourList),
                    _sideItem(this._fourList),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }

  /// 加载更多
  void _getMoreData() {
    this._skip += 10;
    this._loadData();
  }

  /// 下拉刷新
  void _getNewData() {
    this._skip = 0;
    this._list.clear();
    this._controller.resetLoadState();
    this._loadData();
  }

  /// 处理上箭头逻辑
  Widget _upArrow() {
    if (this._count % 2 == 0) {
      return Image.asset(
        "images/up.png",
        fit: BoxFit.fill,
      );
    } else {
      return Image.asset(
        "images/upSeletecd.png",
        fit: BoxFit.fill,
      );
    }
  }

  /// 处理下箭头逻辑
  Widget _downArrow() {
    if (this._count == 2) {
      return Image.asset(
        "images/downSeletecd.png",
        fit: BoxFit.fill,
      );
    } else {
      return Image.asset(
        "images/down.png",
        fit: BoxFit.fill,
      );
    }
  }

  /// 顶部筛选header
  Widget _filterHeader() {
    return Positioned(
      height: ScreenAdaper.height(80),
      width: ScreenAdaper.getScreenWidth(),
      top: 0,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 1,
          color: Colors.black12,
        ))),
        child: Row(
          children: this._filterList.map((value) {
            return Expanded(
                child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      /// 如果是筛选，弹出抽屉
                      String id = value["id"];
                      if (id == "4") {
                        this._scaffoldKey.currentState.openEndDrawer();
                      }

                      if (id == "2") {
                        /// 点击销量
                        if (value["seletecd"] == "1") {
                          return;
                        }
                        setState(() {
                          this._filterList.map((value) {
                            if (value["id"] == "1") {
                              value["seletecd"] = "0";
                            }
                            if (value["id"] == "3") {
                              value["seletecd"] = "0";
                            }
                          }).toList();
                          value["seletecd"] = "1";
                        });
                        this._count = 0;
                        this._isSales = "-sales";
                        this._controller.callRefresh();
                      }

                      if (id == "1") {
                        /// 点击综合
                        this._isSales = "sales";
                        if (value["seletecd"] == "1") {
                          return;
                        }
                        setState(() {
                          this._filterList.map((value) {
                            if (value["id"] == "2") {
                              value["seletecd"] = "0";
                            }
                            if (value["id"] == "3") {
                              value["seletecd"] = "0";
                            }
                          }).toList();
                          value["seletecd"] = "1";
                        });
                        this._count = 0;
                        this._isSales = "sales";
                        this._controller.callRefresh();
                      }

                      if (id == "3") {
                        /// 点击价格
                        setState(() {
                          this._count++;
                          if (this._count == 3 || this._count == 0) {
                            this._count = 1;
                            value["seletecd"] = "0";
                          }
                          if (this._count % 2 == 0 || this._count % 2 == 1) {
                            value["seletecd"] = "1";
                          }

                          this._filterList.map((value) {
                            if (value["id"] == "1") {
                              value["seletecd"] = "0";
                            }
                            if (value["id"] == "2") {
                              value["seletecd"] = "0";
                            }
                          }).toList();
                        });
                        this._isSales = "sales";
                        this._isSales = "";
                        this._controller.callRefresh();
                      }
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "${value["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: value["seletecd"] == "1"
                                          ? Colors.red
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                value["title"] == "价格"
                                    ? Container(
                                        height: ScreenAdaper.height(60),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              height: 6,
                                              width: 10,
                                              child: this._upArrow(),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Container(
                                              height: 6,
                                              width: 10,
                                              child: this._downArrow(),
                                            )
                                          ],
                                        ),
                                      )
                                    : Text(""),
                                value["title"] == "筛选"
                                    ? Container(
                                        height: 16,
                                        width: 20,
                                        child: value["seletecd"] == "0"
                                            ? Image.asset("images/filter.png")
                                            : Image.asset(
                                                "images/filterSeletecd.png"),
                                      )
                                    : Text(""),
                              ],
                            ))
                      ],
                    )));
          }).toList(),
        ),
      ),
    );
  }

  /// 自定义导航条
  Widget _customAppbar(context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    return GHCustomAppbar(
      contentHeight: topPadding + 20,
      leadingWidget: Container(
        padding: EdgeInsets.only(left: 20),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black38,
            size: 20,
          ),
        ),
      ),
      titleWidget: Container(
        child: Container(
          width: ScreenAdaper.getScreenWidth() - 100,
          height: ScreenAdaper.height(50),
          decoration: BoxDecoration(
            color: Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                alignment: Alignment.center,
                child: Icon(
                  Icons.search,
                  color: Colors.black12,
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: ScreenAdaper.height(50),
                width: ScreenAdaper.width(240),
                child: TextField(
                  maxLength: 30,
                  cursorColor: Color.fromRGBO(170, 170, 170, 1),
                  onChanged: (value) {
//                        this._keywors = value;
                  },
                  style: TextStyle(fontSize: 14),
                  autofocus: false,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 0, top: 0),
                      counterText: '',
                      hintText: "请输入要搜索的内容",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(170, 170, 170, 0.1),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
      trailingWidget: Container(
          alignment: Alignment.center,
          width: 40,
          child: GestureDetector(
            onTap: () {
              print("切换布局");
            },
            child: Icon(Icons.filter_list),
          )),
    );
  }

  /// 侧滑筛选
  Widget _endDrawer() {
    return Container(
        width: 350,
        child: Drawer(
          child: _sideFilter(),
        ));
  }

  /// 商品列表Item
  Widget _goodsItem(GHGoodsItemModel goodsItemModel) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pushNamed(context, '/GHGoodsDetails', arguments: {
            'id': goodsItemModel.objectId,
          });
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 86,
                width: 120,
                child: new FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: goodsItemModel.url,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: 80,
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              goodsItemModel.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              goodsItemModel.description,
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black38),
                            ),
                          ),
                        ],
                      )),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    "${goodsItemModel.price}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      goodsItemModel.isSelf == "1"
                                          ? Container(
                                              alignment: Alignment.center,
                                              height: 16,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.red,
                                              ),
                                              child: Text(
                                                "自营",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                ),
                                              ))
                                          : SizedBox(
                                              width: 0,
                                            ),
                                      goodsItemModel.isSelf == "1"
                                          ? SizedBox(
                                              width: 5,
                                            )
                                          : SizedBox(
                                              width: 0,
                                            ),
                                      Container(
                                        child: Text(
                                            "${goodsItemModel.evaluate}条评价",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black54)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Text("月售${goodsItemModel.sales}",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.black54)),
                                ),
                              ],
                            )),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Color.fromRGBO(245, 245, 245, 1),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  /// 商品列表
  Widget _goodsList() {
    return Container(
        margin: EdgeInsets.only(top: ScreenAdaper.height(80)),
        child: EasyRefresh.custom(
          enableControlFinishRefresh: false,
          enableControlFinishLoad: true,
          firstRefresh: true,
          controller: this._controller,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _goodsItem(this._list[index]);
                },
                childCount: this._list.length,
              ),
            ),
          ],
          onLoad: () async {
            GHLoading.showLoading(context);
            await Future.delayed(Duration(seconds: 1), () {
              this._getMoreData();
            });
          },
          onRefresh: () async {
            GHLoading.showLoading(context);
            await Future.delayed(Duration(seconds: 1), () {
              this._getNewData();
            });
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(

        /// 侧滑筛选
        endDrawer: this._endDrawer(),

        /// 自定义导航条
        appBar: _customAppbar(context),
        key: this._scaffoldKey,
        body: Stack(
          children: <Widget>[
            /// 商品列表
            this._goodsList(),

            /// 顶部筛选
            this._filterHeader(),
          ],
        ));
  }
}
