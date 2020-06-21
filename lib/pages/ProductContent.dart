import 'package:flutter/material.dart';
import 'productContent/ProductContentFirst.dart';
import 'productContent/ProductContentSecond.dart';
import 'productContent/ProductContentThree.dart';
import '../services/ScreenAdaper.dart';
import '../config/Config.dart';
import 'package:dio/dio.dart';
import '../model/ProductContentModel.dart';
import '../services/EventBus.dart';
import '../services/GHLog.dart';


class ProducttContent extends StatefulWidget {
  final Map arguments;

  ProducttContent({Key key, this.arguments}) : super(key: key);

  @override
  _ProducttContentState createState() => _ProducttContentState();
}

class _ProducttContentState extends State<ProducttContent> {
  List _productContentDataList = [];

  @override
  void initState() {
    super.initState();
    _getContentData();
  }

  _getContentData() async {
    var api = '${Config.domain}api/pcontent?id=${widget.arguments['id']}';
    var result = await Dio().get(api);

    GHLog(result,StackTrace.current);
    var productList = new ProductContentModel.fromJson(result.data);
    setState(() {
      this._productContentDataList.add(productList.result);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(600, 88, 10, 0),
                        items: [
                          PopupMenuItem(
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.home),
                                SizedBox(width: 10),
                                Text("首页"),
                              ],
                            ),
                          )
                        ]);
                    print("s");
                  },
                  icon: Icon(Icons.more)),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 200,
                  child: TabBar(
                    indicatorColor: Colors.red,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      Tab(
                        child: Text("商品"),
                      ),
                      Tab(
                        child: Text("详情"),
                      ),
                      Tab(
                        child: Text("评价"),
                      ),
                    ],
                  ),
                )
              ],
            )),
        body: _productContentDataList.length > 0
            ? Stack(
                children: <Widget>[
                  TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      ProductContentFirst(this._productContentDataList),
                      ProductContentSecond(this._productContentDataList),
                      ProductContentThree(),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    width: ScreenAdaper.getScreenWidth(),
                    height: 90,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                            color: Colors.black12,
                            width: 1,
                          ))),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            width: 100,
                            height: 80,
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.shopping_cart),
                                Text("购物车"),
                              ],
                            ),
                          ),
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
                                  onTap: () {
                                    eventBus.fire(ProductContentEvent('加入购物车'));
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
                                    eventBus.fire(ProductContentEvent('立即购买'));
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
                  )
                ],
              )
            : Text("加载中"),
      ),
    );
  }
}
