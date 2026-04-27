import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class GHToast {
  static Future<bool?> showTost(String toast) {
    return Fluttertoast.showToast(
      msg: toast,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white,
    );
  }
}
