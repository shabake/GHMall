import 'package:flutter/material.dart';
import '../../services/gh_sqflite.dart';
import '../../services/EventBus.dart';
import '../../widget/GHButton.dart';
import '../../services/ScreenAdaper.dart';
import '../../widget/GHDialog.dart';
import '../../widget/GHLoading.dart';

class GHUserPage extends StatefulWidget {
  GHUserPage({Key key}) : super(key: key);

  _GHUserPageState createState() => _GHUserPageState();
}

class _GHUserPageState extends State<GHUserPage> {
  List list = [];
  var actionEventBus;

  getUserInfo() {
    sq.query().then((value) {
      setState(() {
        print(value);
        this.list = value;
        print(this.list.length);
      });
    });
  }

  GHSqflite sq = GHSqflite();

  @override
  void initState() {
    super.initState();
    this.actionEventBus = eventBus.on<LoginSuccessEvent>().listen((event) {
      this.getUserInfo();
    });
    this.getUserInfo();
  }

  void dispose() {
    super.dispose();
    this.actionEventBus.cancel();
  }

  Widget _header() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(
          "images/bg.jpg",
        ),
      )),
      width: double.infinity,
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20, 30, 30, 0),
            child: Image.asset(
              'images/logo.png',
              fit: BoxFit.fill,
              width: 80,
              height: 60,
            ),
          ),
          this.list.length == 0
              ? Container(
                  child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    "登录/注册",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white),
                  ),
                ))
              : Container(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "用户名${this.list.last["username"]}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "电话${this.list.last["mobilePhone"]}",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                )),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Container(
        child: SafeArea(
      top: false,
      child: ListView(
        padding: EdgeInsets.only(top: 0),
        children: <Widget>[
          _header(),
          Column(
            children: <Widget>[
              Container(
                child: ListTile(
                  onTap: () {
                    print("点击");
                  },
                  leading: Icon(
                    Icons.playlist_add,
                    color: Colors.red,
                  ),
                  title: Text("全部订单"),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.payment, color: Colors.red),
                title: Text("待付款"),
              ),
              Divider(),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.shopping_cart, color: Colors.red),
                title: Text("待收货"),
              ),
              Container(
                height: 10,
                color: Color.fromRGBO(245, 245, 245, 1),
              ),
              ListTile(
                leading: Icon(Icons.collections_bookmark, color: Colors.red),
                title: Text("我的收藏"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.people, color: Colors.red),
                title: Text("在线客服"),
              ),
              Container(
                height: 10,
                color: Color.fromRGBO(245, 245, 245, 1),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/GHAddressList');
                },
                leading: Icon(Icons.room, color: Colors.red),
                title: Text("我的地址"),
              ),
              Container(
                height: 20,
                color: Color.fromRGBO(245, 245, 245, 1),
              ),
              this.list.length > 0
                  ? Container(
                      width: ScreenAdaper.getScreenWidth() - 60,
                      child: GHButton(
                        "退出",
                        tapAction: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BaseDialog(
                                  Text("22"),
                                  140,
                                  300,
                                  sureAction: () {
                                    sq.deletedAllData().then((value) {
                                      Navigator.of(context).pop(this);
                                      this.getUserInfo();
                                      GHLoading.hideLoading(context);
                                    });
                                  },
                                );
                              });
                        },
                      ),
                    )
                  : Text(""),
            ],
          )
        ],
      ),
    ));
  }
}
