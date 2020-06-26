import 'package:flutter/material.dart';

typedef clickCallback = void Function(int value);

/// 显示数量子控件
class GHCountItemWidger extends StatefulWidget {
  /// 数量
  int count;

  /// 是否可以点击
  bool isEnable;

  final clickCallback addClick;
  final clickCallback subClick;

  GHCountItemWidger({
    Key key,
    this.isEnable = true,
    this.count,
    this.addClick,
    this.subClick,
  }) : super(key: key);

  _GHCountItemWidgerState createState() => _GHCountItemWidgerState();
}

class _GHCountItemWidgerState extends State<GHCountItemWidger> {
  @override

  /// 数量
  int _count;

  void initState() {
    super.initState();
    this._count = widget.count;
  }

  Widget _centerNumber() {
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
            child: Text("${this._count}"),
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

  Widget _rightNumber() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (!widget.isEnable) {
          print("禁止响应");
          return;
        }
        setState(() {
          this._count++;
        });
        widget.addClick(this._count);
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

  Widget _leftNumber() {
    return GestureDetector(
      onTap: () {
        if (!widget.isEnable) {
          print("禁止响应");
          return;
        }

        if (this._count > 1) {
          setState(() {
            this._count--;
          });
        }
        widget.subClick(this._count);
      },
      behavior: HitTestBehavior.opaque,
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
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          this._leftNumber(),
          this._centerNumber(),
          this._rightNumber(),
        ],
      ),
    );
  }
}
