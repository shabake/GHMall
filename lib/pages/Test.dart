
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  //例子2
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(),
        SliverAppBar(
            pinned: true,
            brightness: Brightness.light,
            expandedHeight: 200,
            title: Text("222"),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: Text("222"),
              ),
            )
        ),
        SliverToBoxAdapter(
          child: Container(
            child: Text("22"),
          ),
        ),

      ],
    );
  }
}
