import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

class ProductContentSecond extends StatefulWidget {
  final List _productContentDataList;

  ProductContentSecond(this._productContentDataList, {Key key})
      : super(key: key);

  @override
  _ProductContentSecondState createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond>
    with AutomaticKeepAliveClientMixin {
  var _id;

  bool get wantKeepAlive => true;

  void initState() {
    super.initState();
    this._id = widget._productContentDataList[0].sId;
    print(_id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
              child: InAppWebView(
            initialUrl: "http://jd.itying.com/pcontent?id=${this._id}",
            onProgressChanged:
                (InAppWebViewController controller, int progress) {},
          ))
        ],
      ),
    );
  }
}
