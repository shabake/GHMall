import 'package:flutter/material.dart';
import '../../model/ProductContentModel.dart';

class CartItem extends StatefulWidget {

  ProductContentItemModel _productContent;

  CartItem(this._productContent, {Key key}) : super(key: key);

  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  ProductContentItemModel _productContent;

  void initState() {
    super.initState();
    this._productContent = widget._productContent;
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
            child: Text("${this._productContent.count}"),
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
        setState(() {
          this._productContent.count =this._productContent.count+1 ;
        });

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
        if (this._productContent.count > 1) {
          setState(() {
            this._productContent.count =this._productContent.count-1 ;
          });
        }
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
