import 'package:flutter/material.dart';

import 'package:sy_flutter_alipay/sy_flutter_alipay.dart';

import 'package:dio/dio.dart';

class AliPay extends StatefulWidget {
  AliPay({Key key}) : super(key: key);

  _AliPayState createState() => _AliPayState();
}

class _AliPayState extends State<AliPay> {

  //执行支付宝支付
  _doAliPay() async{

    //http://agent.itying.com/alipay/

    var serverApi="http://agent.itying.com/alipay/";

    var serverData=await Dio().get(serverApi);

    var payInfo= serverData.data;

    print(serverData.data);


    await SyFlutterAlipay.pay(
      payInfo,
      urlScheme: 'flutteralipay',
      isSandbox: false,
    ).then((payResult) async {
      print('###########' + payResult.toString() + '###########');
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('AliPay'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('支付宝支付'),
                  onPressed:_doAliPay,
                )
              ],
            )
        )
    );
  }
}
