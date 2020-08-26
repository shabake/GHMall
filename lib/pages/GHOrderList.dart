import 'package:flutter/material.dart';
import '../services/httptool.dart';

class GHOrderListPage extends StatefulWidget {
  @override
  _GHOrderListPageState createState() => _GHOrderListPageState();
}

class _GHOrderListPageState extends State<GHOrderListPage> {
  @override
  void initState() {
    super.initState();
    _getOrderList();
  }

  /// 获取订单列表数据
  void _getOrderList() async {
    var url = "https://a4cj1hm5.api.lncld.net/1.1/classes/shopOrderList";
    await HttpRequest.request(url, method: 'GET').then((value) {
      List results = value["results"];
      print(value);
    });
  }

  Widget _orderListWidget() {
    return Container(child: Text("2222"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("订单列表"),
        ),
        body: _orderListWidget());
  }
}
