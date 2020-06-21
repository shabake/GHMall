import 'package:flutter/material.dart';
import '../widget/GHButton.dart';
import 'package:provider/provider.dart';
import '../provider/Cart.dart';

/// 在线支付
class OnlinePayments extends StatefulWidget {
  @override
  _OnlinePaymentsState createState() => _OnlinePaymentsState();
}

class _OnlinePaymentsState extends State<OnlinePayments> {
  bool _seletecd = true;

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("在线支付"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "订单号:13836123",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              height: 10,
              color: Color.fromRGBO(245, 245, 245, 1),
            ),
            Container(
                padding: EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          child: Image.network(
                            "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2335288179,2509273265&fm=26&gp=0.jpg",
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
                        child: Checkbox(
                            activeColor: Colors.red,
                            value: _seletecd,
                            onChanged: (value) {
                              setState(() {
                                _seletecd = !_seletecd;
                              });
                            }),
                      )
                    ])),
            Divider(),
            Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        child: Image.network(
                          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592127646571&di=5ed1f401d3a5df18378058b4ae67e84f&imgtype=0&src=http%3A%2F%2Fi-3.shouji56.com%2F2015%2F8%2F28%2F5dc468e3-6d20-48b7-9f13-5133c0478dc0.jpeg",
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
                      child: Checkbox(
                          activeColor: Colors.red,
                          value: !_seletecd,
                          onChanged: (value) {
                            setState(() {
                              _seletecd = !_seletecd;
                            });
                          }),
                    )
                  ],
                )),
            Divider(),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: InkWell(
                      child: Text(
                          "支付"
                      ),
                    )
                  ),
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
