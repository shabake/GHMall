import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';

class CartItem extends StatefulWidget {
  final Map<String, dynamic> _itemData;
  final bool isEnable;

  const CartItem(
    this._itemData, {
    Key? key,
    this.isEnable = true,
  }) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late Map<String, dynamic> _itemData;
  late Cart cartProvider;

  @override
  void initState() {
    super.initState();
    _itemData = widget._itemData;
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
            child: Text("${_itemData["count"]}"),
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
        if (!widget.isEnable) {
          print("禁止响应");
          return;
        }
        setState(() {
          _itemData["count"]++;
        });
        cartProvider.changeCartList();
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
              child: const Text("+"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartLeftNumber() {
    return InkWell(
      onTap: () {
        if (!widget.isEnable) {
          print("禁止响应");
          return;
        }
        if (_itemData["count"] > 1) {
          setState(() {
            _itemData["count"]--;
          });
        }
        cartProvider.changeCartList();
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
              child: const Text("-"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<Cart>(context);
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
