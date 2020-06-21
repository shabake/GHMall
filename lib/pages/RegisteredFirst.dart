import 'package:flutter/material.dart';
import '../widget/GHTextWidget.dart';
import '../widget/GHButton.dart';
import 'package:flutter/gestures.dart';
import '../services/GHToast.dart';
import 'package:dio/dio.dart';
import '../config/Config.dart';
import '../services/httptool.dart';


/// 注册第一步
class RegisiteredFirst extends StatefulWidget {
  @override
  _RegisiteredFirstState createState() => _RegisiteredFirstState();
}

class _RegisiteredFirstState extends State<RegisiteredFirst> {
  /// 用户手机号
  String tel;

  /// 校验手机号
  bool checkTel(String tel) {
    if (null == tel) {
      GHToast.showTost("请输入手机号");
      return false;
    }

    RegExp reg = new RegExp(r"^1\d{10}$");
    if (reg.hasMatch(this.tel)) {
      return true;
    } else {
      GHToast.showTost("手机号格式不正确,请重新输入");
      return false;
    }
  }

  /// 发送验证码
  /// ///1.1/requestSmsCode
  /// https://a4cj1hm5.api.lncld.net/1.1/requestSmsCode
  sendCode(String tel) async {
//    HttpRequest.request("https://a4cj1hm5.api.lncld.net/1.1/requestSmsCode",params: {
//      "mobilePhoneNumber":tel,
//    }).then((value){
//        print(value);
//    });
    var api = '${Config.domain}api/sendCode';
    var response = await Dio().post(api, data: {"tel": tel});
    if (response.data["success"]) {
      /// {success: true, code: 1648, message: 短信已发送到您的手机请注意查收}
      String code = response.data["code"];
      GHToast.showTost("获取验证码成功,验证码是${code}");
      Navigator.pushNamed(context, '/registeredSecound',
          arguments: {'tel': tel, 'code': code});
    } else {
      GHToast.showTost(response.data["message"]);
    }
  }

  @override
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
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Colors.black12,
                      ),
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.black12,
                      ),
                      left: BorderSide(
                        width: 1,
                        color: Colors.black12,
                      ),
                    )),
                    height: 50,
                    width: 100,
                    alignment: Alignment.center,
                    child: Text(
                      "+86",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    color: Colors.black12,
                    alignment: Alignment.center,
                    height: 20,
                    child: Text(""),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border(
                        top: BorderSide(
                          width: 1,
                          color: Colors.black12,
                        ),
                        right: BorderSide(
                          width: 1,
                          color: Colors.black12,
                        ),
                      )),
                      child: GHTextWidget(
                        "请输入手机号码",
                        fontSize: 20,
                        onChanged: (tel) {
                          this.tel = tel;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                child: GHButton(
                  "下一步",
                  backGroudColor: Colors.red,
                  tapAction: () {
                    /// 校验手机号
                    if (this.checkTel(this.tel)) {
                      this.sendCode(tel);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: RichText(
                    text: TextSpan(
                        text: "遇到问题?",
                        style: TextStyle(color: Colors.black54),
                        children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('点击了隐私政策');
                            },
                          text: "您可以",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('联系客服');
                            },
                          text: "联系客服",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.dashed,
                              color: Colors.blue)),
                    ])),
              )
            ],
          ),
        ));
  }
}
