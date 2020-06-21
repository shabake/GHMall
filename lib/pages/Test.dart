import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestPageState();
  }
}

class TestPageState extends State<TestPage> {
  /*列表滚动控制器*/
  ScrollController _scrollController;

  /*导航栏背景色*/
  Color _actionBarBackColor;

  /*导航栏标题色*/
  Color _actionBarTitleColor;

  /*导航栏下边的分割线颜色*/
  Color _actionBarBottomLineColor;

  /*状态栏文字样式*/
  SystemUiOverlayStyle _systemUiOverlayStyle;

  /*导航栏高度+状态栏高度*/
  double _topHeight = 84;

  /*默认导航栏高度44*/
  double _actionBarHeight = 44;

  /*默认状态栏高度20*/
  double _statusBarHeight = 20;

  @override
  void initState() {
    // TODO: implement initState
    /*默认状态栏文字为白色 light：文字白色  dark：文字黑色*/
    _systemUiOverlayStyle = SystemUiOverlayStyle.light;
    /*导航栏背景色默认透明*/
    _actionBarBackColor = Colors.transparent;
    /*标题文字颜色默认黑色*/
    _actionBarTitleColor = Colors.white;
    /*导航栏底部分割线默认透明*/
    _actionBarBottomLineColor = Colors.transparent;

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      /*
      根据偏移量来控制导航栏透明度 200为我设置的值，可以随意更改,
      透明度为0.0-1.0之间
      */
      double _canshu = _scrollController.offset / 500 > 1.0
          ? 1.0
          : _scrollController.offset / 500;
      print(_canshu);
      setState(() {
        if (_canshu <= 0) {
          //导航栏为白色不透明了，状态栏文字颜色为黑色
          _systemUiOverlayStyle = SystemUiOverlayStyle.light;
          _actionBarTitleColor = Colors.white;
          _actionBarBottomLineColor = Colors.transparent;
          print("heis ");
        } else if (_canshu < 0.5 && _canshu  >0 ) {
          //导航栏为白色，但是透明度较高，状态栏文字颜色为白色
          _systemUiOverlayStyle = SystemUiOverlayStyle.light;
          _actionBarTitleColor = Colors.white;
          _actionBarBottomLineColor = Colors.transparent;
          print("白色");
          _actionBarBackColor = Color.fromRGBO(255, 255, 255, _canshu);

        } else {
          //导航栏为白色不透明了，状态栏文字颜色为黑色
          _systemUiOverlayStyle = SystemUiOverlayStyle.dark;
          _actionBarTitleColor = Colors.black;
          _actionBarBottomLineColor = Color(0xffe6e6e6);
          print("哈哈 ");
          _actionBarBackColor = Color.fromRGBO(255, 255, 255, _canshu);

        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*动态获取状态栏高度*/
    _statusBarHeight = MediaQuery.of(context).padding.top;
    /*获取状态栏高度+导航栏高度*/
    _topHeight = _statusBarHeight + _actionBarHeight;
    // TODO: implement build
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _systemUiOverlayStyle == null
          ? SystemUiOverlayStyle.light
          : _systemUiOverlayStyle,
      child: Material(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              ListView(
                controller: _scrollController,
                padding: const EdgeInsets.all(0.0), //使内容显示到最上边
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1400,
                    color: Colors.orange,
                  ),
                ],
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: _actionBarBackColor,
                    width: MediaQuery.of(context).size.width,
                    height: this._topHeight,
                    child: Column(
                      children: <Widget>[
                        Expanded(child: Container()),
                                          Container(
                          width: MediaQuery.of(context).size.width,
                          height: this._actionBarHeight,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: _actionBarBottomLineColor,
                                      width: 0.5))),
                          child: Center(
                            child: Text(
                              "我的作品",
                              style: TextStyle(
                                  color: _actionBarTitleColor, fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
