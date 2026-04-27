import 'package:flutter/material.dart';
import 'routers/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// 隐藏debug
      debugShowCheckedModeBanner: false,
      /// 配置路由
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
      /// 设置主题
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
    );
  }
}
