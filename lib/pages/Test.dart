import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sy_flutter_alipay/sy_flutter_alipay.dart';
import 'package:dio/dio.dart';
import 'package:sy_flutter_wechat/sy_flutter_wechat.dart';

class AliPay extends StatefulWidget {
  @override
  _AliPayState createState() => _AliPayState();
}

class _AliPayState extends State<AliPay> {
  @override
  void initState() {
    super.initState();
    _register();
  }

  _register() async {
    bool result = await SyFlutterWechat.register('wx5881fa2638a2ca60');
    print(result);
  }
  _wxPay() async{
    var apiUrl='http://agent.itying.com/wxpay/';
    var myPayInfo =await Dio().get(apiUrl);

    Map myInfo =json.decode(myPayInfo.data);
    print(myInfo);

    var payInfo={
      "appid":myInfo["appid"].toString(),
      "partnerid":myInfo["partnerid"].toString(),
      "prepayid":myInfo["prepayid"].toString(),
      "package":myInfo["package"].toString(),
      "noncestr":myInfo["noncestr"].toString(),
      "timestamp":myInfo["timestamp"].toString(),
      "sign":myInfo["sign"].toString(),
    };
    SyPayResult payResult = await SyFlutterWechat.pay(
        SyPayInfo.fromJson(payInfo)
    );

    print(payResult);
  }

  //支付宝支付
  _doAliPay() async {
    print("支付宝支付...");
    var serverApi = "http://agent.itying.com/alipay/";

    var serverData = await Dio().get(serverApi);

    var payInfo = serverData.data;
    var result = await SyFlutterAlipay.pay(
      payInfo,
      urlScheme: 'flutteralipay', //前面配置的urlScheme
      // isSandbox: true //是否是沙箱环境，只对android有效
    );
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('支付宝支付'),
              onPressed: _doAliPay,
            ),
            RaisedButton(
              child: Text('分享文字'),
              onPressed: () async {
                bool res = await SyFlutterWechat.shareText('hello world',
                    shareType: SyShareType.session);
                print('分享文字：' + res.toString());
              },
            ),
            RaisedButton(
              child: Text('分享图片'),
              onPressed: () async {
                bool res = await SyFlutterWechat.shareImage(
                    'https://avatars0.githubusercontent.com/u/10024776',
                    shareType: SyShareType.timeline);
                print('分享图片：' + res.toString());
              },
            ),
            RaisedButton(
              child: Text('分享网页'),
              onPressed: () async {
                bool res = await SyFlutterWechat.shareWebPage(
                    '标题',
                    '描述',
                    'https://avatars0.githubusercontent.com/u/10024776',
                    'http://www.example.com',
                    shareType: SyShareType.session);
                print('分享网页：' + res.toString());
              },
            ),
            RaisedButton(
              child: Text('支付'),
              onPressed: _wxPay,
            ),
          ],
        ),
      ),
    );
  }
}




