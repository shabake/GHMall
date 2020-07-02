import 'package:flutter/material.dart';
import '../widget/GHButton.dart';
import 'package:provider/provider.dart';
import '../provider/Cart.dart';

/// 在线支付
class GHOnlinePayments extends StatefulWidget {
  Map arguments;

  @override
  GHOnlinePayments({Key key, this.arguments}) : super(key: key);

  _GHOnlinePaymentsState createState() => _GHOnlinePaymentsState();
}

class _GHOnlinePaymentsState extends State<GHOnlinePayments> {
  bool _seletecd = true;
  String _orderId = "";
  @override
  void initState() {
    super.initState();
    this._orderId = widget.arguments["id"];
  }

  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("在线支付"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Container(
              child: Text(
                "订单号: ${this._orderId}",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              height: 20,
              color: Color.fromRGBO(245, 245, 245, 1),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  this._seletecd = !this._seletecd;
                });
              },
              child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                    Row(children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        child: Image.asset(
                          'images/pay_wechat.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text(
                          "微信",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ]),
                    Container(
                        width: 20,
                        height: 20,
                        child: this._seletecd == true
                            ? Image.asset('images/checkSelected.png')
                            : Image.asset('images/checkNormal.png'))
                  ])),
            ),
            Divider(),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  this._seletecd = !this._seletecd;
                });
              },
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    Container(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        'images/pay_alipay.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Text(
                        "支付宝",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ]),
                  Container(
                      width: 20,
                      height: 20,
                      child: this._seletecd != true
                          ? Image.asset('images/checkSelected.png')
                          : Image.asset('images/checkNormal.png'))
                ],
              )),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      child: InkWell(
                    child: Text("支付"),
                  )),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    child: Text("￥${cartProvider.totalPrice + 10}"),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: GHButton(
                "支付",
                tapAction: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
