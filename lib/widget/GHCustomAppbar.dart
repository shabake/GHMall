import 'package:flutter/material.dart';

/// 这是一个可以指定SafeArea区域背景色的AppBar
/// PreferredSizeWidget提供指定高度的方法
/// 如果没有约束其高度，则会使用PreferredSizeWidget指定的高度

class GHCustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final double contentHeight; //从外部指定高度
  Color navigationBarBackgroundColor; //设置导航栏背景的颜色
  Widget leadingWidget;
  Widget trailingWidget;
  Widget titleWidget;

  GHCustomAppbar({
    @required this.leadingWidget,
    this.contentHeight = 44,
    this.navigationBarBackgroundColor = Colors.white,
    this.titleWidget,
    this.trailingWidget,
  }) : super();

  @override
  State<StatefulWidget> createState() {
    return new _GHCustomAppbarState();
  }

  @override
  Size get preferredSize => new Size.fromHeight(contentHeight);
}

/// 这里没有直接用SafeArea，而是用Container包装了一层
/// 因为直接用SafeArea，会把顶部的statusBar区域留出空白
/// 外层Container会填充SafeArea，指定外层Container背景色也会覆盖原来SafeArea的颜色
///     var statusheight = MediaQuery.of(context).padding.top;  获取状态栏高度

class _GHCustomAppbarState extends State<GHCustomAppbar> {
  @override
  void initState() {
    super.initState();
  }
  get _drawer =>Drawer(
    child: Text('This is Drawer'),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black38,
              offset: Offset(0.01, 0.01),
              blurRadius: 10.0,
              spreadRadius: 0.01),
          BoxShadow(
              color: Colors.black38,
              offset: Offset(
                0.01,
                0.01,
              )),
          BoxShadow(color: Colors.white)
        ],
      ),
      child: SafeArea(
        top: true,
        child: Container(
            width: double.infinity,
            decoration: UnderlineTabIndicator(
              borderSide: BorderSide(width: 1.0, color: Color(0xFFeeeeee)),
            ),
            height: widget.contentHeight,
            child: Row(
              children: <Widget>[
                Container(
                  child: Container(
                    child: widget.leadingWidget,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  child: widget.titleWidget,
                ),
                Container(
                  child: Container(
                    child: widget.trailingWidget,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
