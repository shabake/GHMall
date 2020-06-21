import 'package:flutter/material.dart';
import '../widget/GHTextWidget.dart';
import '../widget/GHButton.dart';
import 'RegisteredFirst.dart';
import '../services/GHToast.dart';
import '../config/Config.dart';
import 'package:dio/dio.dart';
import '../services/gh_sqflite.dart';
import '../services/EventBus.dart';
import 'package:flutter/gestures.dart';
import 'dart:core';

/// 登录页面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController usernameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  /// 用户名
  var _username;

  /// 密码
  var _password;

  @override
  void initState() {
    super.initState();
  }
  @override
  bool checkParameters(String username, String password) {
    if (username == null || password == null) {
      return false;
    }
    if (password.length < 4 || password.length > 20) {
      GHToast.showTost("手机号格式不正确,请重新输入");
      return false;
    }
    RegExp reg = new RegExp(r"^1\d{10}$");
    if (reg.hasMatch(username)) {
      return true;
    } else {
      GHToast.showTost("手机号格式不正确,请重新输入");
      return false;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              /// logo
              Container(
                  margin: EdgeInsets.only(top: 30, bottom: 30),
                  child: Center(
                    child: Image.asset(
                      'images/logo.png',
                      fit: BoxFit.fill,
                      width: 100,
                      height: 100,
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                child: GHTextWidget(
                  "请输入用户名",
                  onChanged: (value) {
                    this._username = value;
                  },
                  textEditingController:this.usernameEditingController,
                ),
              ),
              Container(
                child: GHTextWidget(
                  "请输入密码",
                  onChanged: (value) {
                    this._password = value;
                  },
                  textEditingController:this.passwordEditingController,
                ),
              ),
              Container(
                  height: 50,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          print("忘记密码");
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "忘记密码",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/registeredFirst');
                          print("注册");
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "注册",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                height: 50,
                child: GHButton(
                  "登 录",
                  backGroudColor: Colors.red,
                  tapAction: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    var username = this._username.trim();
                    var password = this._password.trim();
                    if (this.checkParameters(username, password)) {
                      this._login(username, password);
                    }
                  },
                ),
              ),
              SizedBox(height: 5,),
              Container(
                child: RichText(
                    text: TextSpan(
                        text: "登录即代表同意",
                        style: TextStyle(color: Colors.black),
                        children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('点击了隐私政策');
                            },
                          text: "《隐私协议》",
                          style: TextStyle(color: Colors.blue)),
                    ])),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black38,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              GHToast.showTost("点击了联系客服");
            },
            child: Text(
              "客服",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  _login(String user, String password) async {
    var api = '${Config.domain}api/doLogin';
    var response =
        await Dio().post(api, data: {"username": user, "password": password});

    print(response);

    ///{"success":true,"message":"登录成功","userinfo":
    ///[{"_id":"5ee0c2c4283a0e16607c88bd","username":"18301402058","tel":"18301402058","salt":"dfa037a53e121ecc9e0926800c3e814e"},
    ///{"_id":"5ee0c443283a0e16607c88be","username":"18301402058","tel":"18301402058","salt":"dfa037a53e121ecc9e0926800c3e814e"}]}
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
    Navigator.pop(context);
  }
}
