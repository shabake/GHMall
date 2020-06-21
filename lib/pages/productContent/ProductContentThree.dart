import 'package:flutter/material.dart';

class ProductContentThree extends StatefulWidget {
  @override
  _ProductContentThreeState createState() => _ProductContentThreeState();
}

class _ProductContentThreeState extends State<ProductContentThree> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return SafeArea(
            child: SizedBox(
              child: Column (
                children: <Widget>[
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(10),
                    height: 60,
                    child: Text("猜测是"),
                  ),
                  Divider(height: 120,),
                ],
              ),
            )
        );
      },
      itemCount: 14,
    );
  }
}
