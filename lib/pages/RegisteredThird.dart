import 'package:flutter/material.dart';
import '../widget/GHTextWidget.dart';
import '../widget/GHButton.dart';
import 'package:dio/dio.dart';
import '../config/Config.dart';
import '../services/GHToast.dart';
import '../services/GHToast.dart';
import '../pages/tabs/Tabs.dart';
import '../services/gh_sqflite.dart';
import '../services/EventBus.dart';

/// 注册第三步
class RegisterrdThird extends StatefulWidget {
  final Map arguments;

  RegisterrdThird({Key key, this.arguments}) : super(key: key);

  @override
  _RegisterrdThirdState createState() => _RegisterrdThirdState();
}

class _RegisterrdThirdState extends State<RegisterrdThird> {
  /// 手机号码
  String tel;

  /// 验证码
  String code;

  /// 用户登录密码
  String password;

  String dbName = "user.db";


  @override
  void initState() {
    super.initState();
    this.tel = widget.arguments["tel"];
    this.code = widget.arguments["code"];
  }

  /// 校验用户密码长度
  bool checkPassword(String password) {
    if (password == null) {
      GHToast.showTost("请输入密码");
      return false;
    }

    if (password.length > 20 || password.length < 4) {
      GHToast.showTost("请设置6-20字符");
      return false;
    }
    return true;
  }

  /// 用户注册接口
  userRegistration(String tel, String code, String password) async {
    var api = '${Config.domain}api/register';
    var response = await Dio()
        .post(api, data: {"tel": tel, "code": code, "password": password});
    if (response.data["success"]) {
      //{"success":true,"message":"注册成功","userinfo":
      // [
      // {"_id":"5ee0c2c4283a0e16607c88bd",
      // "username":"18301402058",
      // "tel":"18301402058",
      // "salt":"dfa037a53e121ecc9e0926800c3e814e"}
      // ]
      // }
      List userinfo = response.data["userinfo"];
      String _id = userinfo.first["_id"];
      String tel = userinfo.first["tel"];
      String salt = userinfo.first["salt"];
      String username = userinfo.first["username"];

      GHSqflite sq = GHSqflite();
      sq.add(_id, username, tel, salt);

      /// 发送广播
      eventBus.fire(LoginSuccessEvent('登录成功'));

      /// 返回到根控制器
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => new Tabs()),
          (route) => route == null);
    }
    print(response);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("手机快速注册"),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "请设置登录密码",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black12, width: 1)

                              ///边框颜色、宽
                              ),
                          height: 50,
                          child: Container(
                            child: GHTextWidget(
                              "请设置6-20字符",
                              isShowBottomLine: false,
                              fontSize: 14,
                              onChanged: (password) {
                                this.password = password;
                              },
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, top: 0),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: true,
                      onChanged: null,
                    ),
                    Text("密码可见"),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text("密码可见密码可见密码可见密码可见密码可见密码可见密码可见密码可见密码可见密码可见密码可见密码可见"),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: GHButton(
                  "确定",
                  tapAction: () {
                    if (this.checkPassword(this.password)) {
                      this.userRegistration(this.tel, this.code, password);
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
