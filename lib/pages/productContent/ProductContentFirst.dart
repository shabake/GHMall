import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../model/ProductContentModel.dart';
import '../../config/Config.dart';
import '../../services/CartServies.dart';
import '../../services/EventBus.dart';
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';
import '../productContent/CartItem.dart';

class ProductContentFirst extends StatefulWidget {
  final List _productContentDataList;

  ProductContentFirst(this._productContentDataList, {Key key})
      : super(key: key);

  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst>
    with AutomaticKeepAliveClientMixin {
  ProductContentItemModel _productContent;

  bool get wantKeepAlive => true;
  List _attr = [];
  String _seletectValue = "";
  var cartProvider;
  var actionEventBus;

  _initAttr() {
    var attr = this._productContent.attr;
    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].list.length; j++) {
        if (j == 0) {
          attr[i].attrList.add({
            "title": attr[i].list[j],
            "check": true,
          });
        } else {
          attr[i].attrList.add({
            "title": attr[i].list[j],
            "check": false,
          });
        }
      }
    }
    _attr = attr;
  }

  _getSelectedAttr() {
    var attr = this._attr;

    List temoArr = [];
    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].attrList.length; j++) {
        if (attr[i].attrList[j]["check"] == true) {
          temoArr.add(attr[i].attrList[j]["title"]);
        }
      }
    }
    setState(() {
      _seletectValue = temoArr.join(',');
      this._productContent.seletecAttr = this._seletectValue;
    });
  }

  _changeAttr(cate, title, setBottomState) {
    var attr = this._productContent.attr;
    for (var i = 0; i < attr.length; i++) {
      if (attr[i].cate == cate) {
        for (var j = 0; j < attr[i].list.length; j++) {
          attr[i].attrList[j]["check"] = false;
          if (title == attr[i].attrList[j]["title"]) {
            attr[i].attrList[j]["check"] = true;
          }
        }
      }
    }
    setBottomState(() {
      this._attr = attr;
      print(attr[0].cate);
    });
    _getSelectedAttr();
  }

  @override
  void initState() {
    super.initState();
    this.actionEventBus = eventBus.on<ProductContentEvent>().listen((event) {
      this._showBottomSheet();
    });
    this._productContent = widget._productContentDataList[0];
    this._attr = _productContent.attr;
    _initAttr();
    _getSelectedAttr();
  }

  void dispose() {
    super.dispose();
    this.actionEventBus.cancel();
  }

  _showBottomSheet() {
    // 规格选择数据
    //[{"cate":"鞋面材料","list":["牛皮 "]},{"cate":"闭合方式","list":["系带"]},{"cate":"颜色","list":["红色","白色","黄色"]}]
    /*
     *
     *  [{
            	"cate": "鞋面材料",
            	"list": ["牛皮 "]
        }, {
            	"cate": "闭合方式",
            	"list": ["系带"]
        }, {
	            "cate": "颜色",
            	"list": ["红色", "白色", "黄色"]
    }]
     */

    List filters = _attr;
    List<Widget> _getAttrItemWidget(attrItem, setBottomState) {
      List<Widget> attrItemList = [];
      attrItem.attrList.forEach((item) {
        attrItemList.add(Container(
          child: Container(
              width: 60,
              child: InkWell(
                onTap: () {
                  _changeAttr(
                      "${attrItem.cate}", item["title"], setBottomState);
                },
                child: Chip(
                    backgroundColor:
                        item["check"] ? Colors.lightBlue : Colors.black12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0)),
                    label: Container(
                      child: Text(
                        item["title"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    )),
              )),
        ));
      });
      return attrItemList;
    }

    List<Widget> _getFilter(filters, setBottomState) {
      // 内层循环
      List<Widget> filter = [];
      filters.forEach((item) {
        /// 遍历子数组
        filter.add(Wrap(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 80,
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "${item.cate}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Wrap(
                    children: _getAttrItemWidget(item, setBottomState),
                  ),
                ),
              ],
            )
          ],
        ));
      });
      return filter;
    }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setBottomState) {
            return Container(
              height: 340,
              child: Stack(
                children: <Widget>[
                  /// 规格选择部分
                  Container(
                    padding: EdgeInsets.all(10),
                    child: ListView(
                      children: <Widget>[
                        Column(
                          /// 外层数组
                          children: _getFilter(filters, setBottomState),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("数量"),
                              CartItem(this._productContent),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    width: ScreenAdaper.getScreenWidth(),
                    height: 90,
                    bottom: 0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            height: 50,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: InkWell(
                                child: Text(
                                  "加入购物车",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                onTap: () async {
                                  _getSelectedAttr();
                                  await CartServices.addCart(
                                      this._productContent);
                                  this.cartProvider.updataCartList();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orange,
                            ),
                            height: 50,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  print("立即购买");
                                },
                                child: Text(
                                  "立即购买",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    this.cartProvider = Provider.of<Cart>(context);
    String sPic = this._productContent.pic;
    sPic = Config.domain + sPic.replaceAll('\\', '/');
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        /// 顶部大图
        children: <Widget>[
          Container(
            height: 320,
            child: Image.network(
              sPic,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              this._productContent.title.length > 0
                  ? this._productContent.title
                  : "2",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          Container(
            child: Text(
              this._productContent.subTitle.length > 0
                  ? this._productContent.subTitle
                  : "2",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "特价: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Text(
                        this._productContent.oldPrice + "元",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        child: Text(
                      "原价",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    SizedBox(width: 10),
                    Container(
                      child: Text(this._productContent.price,
                          style: TextStyle(color: Colors.black54)),
                    )
                  ],
                ),
              ],
            ),
          ),
          this._attr.length > 0
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  child: InkWell(
                    onTap: () {
                      _showBottomSheet();
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          "已选: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _seletectValue,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                )
              : Text(""),
          Divider(),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Text("运费: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("免运费", style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Text("数量: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("${this._productContent.count}",
                    style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
