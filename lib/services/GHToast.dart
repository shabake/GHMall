import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class GHToast{

  static Future<void> showTost(String toast) {
    Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        textColor: Colors.white,
    );
  }
}
