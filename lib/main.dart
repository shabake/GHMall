import 'package:flutter/material.dart';
import 'routers/router.dart';
import 'package:provider/provider.dart';
import 'provider/Cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() {
  /// 将状态栏设置为白色
//  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(builder: (_) => Cart())],
      child: MaterialApp(
        /// 隐藏debug
        debugShowCheckedModeBanner: false,
        /// 配置路由
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
        /// 设置主题
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
      ),
    );
  }
}
