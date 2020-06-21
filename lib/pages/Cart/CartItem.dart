import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';

class CartItem extends StatefulWidget {


  /// 数据模型
  Map _itemData;

  bool isEnable;

  CartItem(this._itemData, {Key key,this.isEnable = true}) : super(key: key);

  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Map _itemData;
  var cartProvider;

  void initState() {
    super.initState();
    this._itemData = widget._itemData;
  }

  Widget _cartCenterNumber() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        width: 1,
        color: Colors.black12,
      )),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 40,
            height: 20,
            child: Text("${this._itemData["count"]}"),
            decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(
                    width: 0.5,
                    color: Colors.black12,
                  ),
                  right: BorderSide(
                    width: 1,
                    color: Colors.black12,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartRightNumber() {
    return InkWell(
      onTap: () {
        if(!widget.isEnable) {
          print("禁止响应");
          return;
        }
        setState(() {

          this._itemData["count"]++;
        });
        this.cartProvider.changeCartList();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          width: 1,
          color: Colors.black12,
        )),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 20,
              height: 20,
              child: Text("+"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartLeftNumber() {
    return InkWell(
      onTap: () {
        if(!widget.isEnable) {
          print("禁止响应");
          return;
        }
        if (this._itemData["count"] > 1) {
          setState(() {
            this._itemData["count"]--;
          });
        }
        this.cartProvider.changeCartList();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          width: 1,
          color: Colors.black12,
        )),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 20,
              height: 20,
              child: Text("-"),
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    this.cartProvider = Provider.of<Cart>(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _cartLeftNumber(),
          _cartCenterNumber(),
          _cartRightNumber(),
        ],
      ),
    );
  }
}
