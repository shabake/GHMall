import 'package:flutter/material.dart';

typedef MenuCallBack = void Function(int count);

/// 显示数量子控件
class GHCountItemWidger extends StatefulWidget {


  /// 数量
  int count;

  /// 是否可以点击
  bool isEnable;

  /// 点击增加事件
  final Object addAction;

  /// 点击减少事件
  final Object subAction;

  GHCountItemWidger(
      {Key key,
      this.isEnable = true,
      this.count,
      this.addAction,
      this.subAction})
      : super(key: key);

  _GHCountItemWidgerState createState() => _GHCountItemWidgerState();
}


class _GHCountItemWidgerState extends State<GHCountItemWidger> {

  @override

  /// 数量
  int _count;

  MenuCallBack addAction ;


  /// 减少
//  void _subAction() {
//    if (!widget.isEnable) {
//      return;
//    }
//    if (this._count > 1) {
//      setState(() {
//        this._count--;
//      });
//    }
//  }
//
  /// 增加
  void _addAction() {
    if (!widget.isEnable) {
      print("禁止响应");
      return;
    }
    setState(() {
      this._count++;
    });
  }
  void initState() {
    super.initState();
    this._count = widget.count;
    addAction = widget.addAction;
//    subAction = widget.subAction;
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
    return InkWell(
//      onTap: this.addAction,
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
    return InkWell(
//      onTap: this.subAction,
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
