import 'package:flutter/material.dart';

class GHButton extends StatelessWidget {
  /// 背景颜色
  final Color backGroudColor;

  /// 标题
  final String title;

  /// 点击事件
  final Object tapAction;

  @override
  GHButton(this.title,
      {Key key, this.tapAction, this.backGroudColor = Colors.red})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.red),
      height: 50,
      child: TextButton(
        onPressed: this.tapAction,
        child: Text(
          this.title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
