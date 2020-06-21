import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';
import '../widget/GHButton.dart';
import '../widget/GHCustomAppbar.dart';

/// 搜索
class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  /// 用户输入的关键字
  var _keywors;

  /// 热搜关键字
  var _hotwords = [
    {"key": "apple", "type": "1"},
    {"key": "小米", "type": "1"},
    {"key": "华为", "type": "1"},
    {"key": "魅族", "type": "1"},
    {"key": "iPad", "type": "1"},
    {"key": "口罩", "type": "1"}
  ];

  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    final double topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
          child: Container(
        child: Text("22"),
      )),
      appBar: GHCustomAppbar(
        contentHeight: topPadding + 44,
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
                      this._keywors = value;
                    },
                    style: TextStyle(fontSize: 14),
                    autofocus: true,
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
            child: InkWell(
              onTap: () {
                print("222");
                _scaffoldKey.currentState.openDrawer();
              },
              child: Text(
                "搜索",
                style: TextStyle(fontSize: 14),
              ),
            )),
      ),
      body: ListView(
        children: <Widget>[
          _commomTitleWidget("热搜", Icons.whatshot),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  children: this._hotwords.map((value) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Chip(
                        backgroundColor: Color.fromRGBO(235, 235, 235, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        label: Text("${value["key"]}"),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          _commomTitleWidget("历史记录", Icons.history),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding:
                      EdgeInsets.only(left: 20, top: 10, right: 10, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "apple",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {
                            print("删除");
                          },
                          child: Icon(Icons.delete_outline),
                        ),
                      )
                    ],
                  )),
              Divider(),
              Container(
                padding: EdgeInsets.only(top: 50),
                width: ScreenAdaper.getScreenWidth() - 40,
                child: GHButton(
                  "清空历史记录",
                  tapAction: () {
                    print("清空");
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _commomTitleWidget(text, iconData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    iconData,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  child: Text(text,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            )),
        Divider(),
      ],
    );
  }
}
