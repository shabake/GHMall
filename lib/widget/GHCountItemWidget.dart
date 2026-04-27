import 'package:flutter/material.dart';

typedef clickCallback = void Function(int value);

/// 显示数量子控件
class GHCountItemWidger extends StatefulWidget {
  final int? count;
  final bool isEnable;
  final clickCallback? addClick;
  final clickCallback? subClick;

  const GHCountItemWidger({
    Key? key,
    this.isEnable = true,
    this.count,
    this.addClick,
    this.subClick,
  }) : super(key: key);

  @override
  State<GHCountItemWidger> createState() => _GHCountItemWidgerState();
}

class _GHCountItemWidgerState extends State<GHCountItemWidger> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.count ?? 1;
  }

  Widget _centerNumber() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black12,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 40,
            height: 20,
            child: Text("$_count"),
            decoration: BoxDecoration(
              border: Border(
                left: const BorderSide(
                  width: 0.5,
                  color: Colors.black12,
                ),
                right: const BorderSide(
                  width: 1,
                  color: Colors.black12,
                ),
              ),
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
          _count++;
        });
        widget.addClick?.call(_count);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black12,
          ),
        ),
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

  Widget _leftNumber() {
    return GestureDetector(
      onTap: () {
        if (!widget.isEnable) {
          print("禁止响应");
          return;
        }
        if (_count > 1) {
          setState(() {
            _count--;
          });
        }
        widget.subClick?.call(_count);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black12,
          ),
        ),
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
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _leftNumber(),
          _centerNumber(),
          _rightNumber(),
        ],
      ),
    );
  }
}
