import 'package:flutter/material.dart';
import '../widget/GHTextWidget.dart';
import '../widget/GHButton.dart';
import '../services/GHToast.dart';
import 'package:dio/dio.dart';
import '../config/Config.dart';

/// 注册第二步
class RegisiteredSecond extends StatefulWidget {
  final Map arguments;

  RegisiteredSecond({Key key, this.arguments}) : super(key: key);

  @override
  _RegisiteredSecondState createState() => _RegisiteredSecondState();
}

class _RegisiteredSecondState extends State<RegisiteredSecond> {
  /// 手机号码
  String tel;

  /// 验证码 (服务器返回)
  String code;

  /// 验证码 (用户输入)
  String userCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.tel = widget.arguments["tel"];
    this.code = widget.arguments["code"];
  }

  /// 验证用户输入的验证码
  bool checkCode(String code) {
    if (code == null) {
      GHToast.showTost("请输入验证码");
      return false;
    }
    return true;
  }

  /// 验证验证码接口
  validateCode(String tel, String code) async {
    var api = '${Config.domain}api/validateCode';
    var response = await Dio().post(api, data: {"tel": tel, "code": code});
    if (response.data["success"]) {
      Navigator.pushNamed(context, '/registeredThird', arguments: {
        "tel": this.tel,
        "code": this.code,
      });
    } else {
      GHToast.showTost(response.data["message"]);
    }
  }

  Widget build(BuildContext context) {
    print(widget.arguments);

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
            Container(
              child: Text("请输入${this.tel}收到的验证码"),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1)

                        ///边框颜色、宽
                        ),
                    width: 240,
                    height: 50,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: GHTextWidget(
                        this.code,
                        isShowBottomLine: false,
                        onChanged: (code) {
                          this.userCode = code;
                        },
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
                          border: Border.all(color: Colors.black12, width: 1)

                          ///边框颜色、宽
                          ),
                      child: FlatButton(
                        onPressed: null,
                        child: Text("重新发送"),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: GHButton(
                "下一步",
                tapAction: () {
                  if (this.checkCode(this.code)) {
                    this.validateCode(this.tel, this.code);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
