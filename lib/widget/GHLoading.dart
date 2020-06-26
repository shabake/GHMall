import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnSuccess = void Function(Object o);
typedef OnError = void Function(Exception e);


class GHLoading {

  static bool isShow = false;

  static Object dismiss;

  static showLoading(BuildContext context) {
    if (!isShow) {
      isShow = true;
      showGeneralDialog(
          context: context,
          // barrierColor: Colors.white, // 背景色
          barrierLabel: "加载中",
          barrierDismissible: false,
          // 是否能通过点击空白处关闭
          transitionDuration: const Duration(milliseconds: 150),
          // 动画时长
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return Align(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Theme(
                  data: ThemeData(
                    cupertinoOverrideTheme: CupertinoThemeData(
                      brightness: Brightness.dark,
                    ),
                  ),
                  child: CupertinoActivityIndicator(
                    radius: 14,
                  ),
                ),
              ),
            );
          }).then((value) {
        isShow = false;
      });
    }
  }

  static hideLoading(BuildContext context) {
    if (isShow) {
      Navigator.of(context).pop();
    }
  }
}
