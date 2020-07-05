import 'package:flutter/material.dart';
import '../widget/GHTextWidget.dart';
import '../widget/GHButton.dart';
import '../services/GHToast.dart';
import '../services/gh_sqflite.dart';
import '../services/EventBus.dart';
import 'package:flutter/gestures.dart';
import 'dart:core';
import '../services/httptool.dart';

/// 登录页面
class GHLoginPage extends StatefulWidget {
  @override
  _GHLoginPageState createState() => _GHLoginPageState();
}

class _GHLoginPageState extends State<GHLoginPage> {
  /// 手机号码
  TextEditingController _mobilePhoneNumberEditingController =
      TextEditingController();

  /// 验证码
  TextEditingController _codeEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  /// 注册或登录
  void _login(String mobilePhoneNumber, String smsCode) async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/usersByMobilePhone";
    Map<String, dynamic> params = {
      "mobilePhoneNumber": "+86${mobilePhoneNumber}",
      "smsCode": smsCode,
    };
    print(params);
    await HttpRequest.request(url, method: 'POST', params: params).then((res) {
      print(res);
      if (res == null) {
        GHToast.showTost("登录失败,请重试");
      } else {
        GHToast.showTost("登录成功");
        String objectId = res["objectId"];
        String username = res["username"];
        String mobilePhone = res["mobilePhoneNumber"];
        GHSqflite sqflite = GHSqflite();
        sqflite.add(objectId, username, mobilePhone);

        /// 发送广播
        eventBus.fire(LoginSuccessEvent('登录成功'));

        /// 返回到根控制器
        Navigator.pop(context);
      }
    });
  }

  /// 请求验证码
  void _requestSmsCode(String mobilePhoneNumber) async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/requestSmsCode";
    Map<String, dynamic> params = {
      "mobilePhoneNumber": mobilePhoneNumber,
    };
    await HttpRequest.request(url, method: 'POST', params: params).then((res) {
      if (res == null) {
        GHToast.showTost("请求验证码失败");
      } else {
        GHToast.showTost("请求验证码成功");
      }
    });
  }

  /// 校验手机号码
  bool _checkParameters(String username) {
    if (username == null) {
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
                height: 50,
                child: GHTextWidget(
                  "请输入用户名",
                  onChanged: (value) {},
                  textEditingController:
                      this._mobilePhoneNumberEditingController,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  Container(
                    width: 240,
                    height: 50,
                    child: Container(
                      child: GHTextWidget(
                        "验证码",
                        textEditingController: this._codeEditingController,
                      ),
                    ),
                  ),
                  Container(
                    width: 10,
                    child: Text(""),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1)),
                      child: FlatButton(
                        onPressed: () {
                          this._requestSmsCode(
                              this._mobilePhoneNumberEditingController.text);
                        },
                        child: Text(
                          "重新发送",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ),
                    ),
                  )
                ],
              )),

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
                    ],
                  )),
              Container(
                height: 50,
                child: GHButton(
                  "登录",
                  backGroudColor: Colors.red,
                  tapAction: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    var username =
                        this._mobilePhoneNumberEditingController.text.trim();
                    if (this._checkParameters(username)) {
                      this._login(this._mobilePhoneNumberEditingController.text,
                          this._codeEditingController.text);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
}
