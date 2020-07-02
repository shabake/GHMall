import 'package:flutter/material.dart';

class GHRichTextPriceWidget extends StatelessWidget {
  /// 传入价格
  double price = 0.0;

  @override
  GHRichTextPriceWidget(this.price, {Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      child: RichText(
          text: TextSpan(
              text: "¥",
              style: TextStyle(color: Colors.red, fontSize: 10),
              children: [
            TextSpan(
                text: "${price}",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: ".00",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ])),
    );
  }
}
