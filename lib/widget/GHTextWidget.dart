import 'package:flutter/material.dart';

/// 封装TextWidget
class GHTextWidget extends StatelessWidget {
  /// 占位文字
  final String text;

  /// 点击事件
  final Object onChanged;

  /// 字号
  final double fontSize;

  /// 是否显示底部线条 默认显示
  final bool isShowBottomLine;

  final TextEditingController textEditingController;

  @override
  GHTextWidget(this.text,
      {Key key,
      this.onChanged = null,
      this.fontSize = 14,
      this.isShowBottomLine = true,
      this.textEditingController})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 1,
        color:
            this.isShowBottomLine == true ? Colors.black12 : Colors.transparent,
      ))),
      height: 50,
      child: TextField(
          controller: this.textEditingController,
          style: TextStyle(
            fontSize: this.fontSize,
          ),
          onChanged: this.onChanged,
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () {
                WidgetsBinding.instance.addPostFrameCallback(
                    (_) => this.textEditingController.text = "");
              },
              child: Icon(
                (Icons.clear),
              ),
            ),
            contentPadding: EdgeInsets.only(left: 0, top: 0),
            hintText: this.text,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none),
          )),
    );
  }
}
