import 'package:flutter/material.dart';

class BaseDialog extends Dialog {
  final Object cancelAction;

  final Object sureAction;

  //子控件
  final Widget widget;

  // 高
  final double height;

  //宽
  final double width;

  BaseDialog(this.widget, this.height, this.width,
      {Key key, this.cancelAction, this.sureAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: new Material(
            type: MaterialType.transparency,
            child: new Container(
                height: this.height,
                width: this.width,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ))),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          child: Text(
                        "确定退出吗",
                        style: TextStyle(fontSize: 20),
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              child: Text(
                                "取消",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop(this);
                            },
                          ),
                          InkWell(
                            child: Container(
                              child: Text(
                                "确定",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                            ),
                            onTap: this.sureAction,
                          )
                        ],
                      )
                    ],
                  ),
                ))),
      ),
    );
  }
}
