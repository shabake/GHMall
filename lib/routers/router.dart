import 'package:flutter/material.dart';
import '../pages/tabs/Tabs.dart';
import '../pages/Search.dart';
import '../pages/Login.dart';
import '../pages/RegisteredFirst.dart';
import '../pages/RegisiteredSecond.dart';
import '../pages/RegisteredThird.dart';
import '../pages/GHCheckOut.dart';
import '../pages/GHAddressList.dart';
import '../pages/GHAddressEdit.dart';
import '../pages/OnlinePayments.dart';
import '../pages/GHGoodsList.dart';
import '../pages/GHGoodsDetails.dart';


//配置路由
final routes = {
  '/': (context,{arguments}) => Tabs(arguments:arguments),
  '/search': (context) => SearchPage(),
  '/login': (context) => LoginPage(),
  '/registeredFirst': (context,{arguments}) => RegisiteredFirst(),
  '/registeredSecound': (context,{arguments}) => RegisiteredSecond(arguments:arguments),
  '/registeredThird': (context,{arguments}) => RegisterrdThird(arguments:arguments),
  '/GHCheckOut': (context,{arguments}) => GHCheckOut(arguments:arguments),
  '/GHAddressList': (context,{arguments}) => GHAddressList(),
  '/GHAddressEdit': (context,{arguments}) => GHAddressEdit(arguments:arguments),
  '/OnlinePayments': (context,{arguments}) => OnlinePayments(),
  '/GHGoodsList': (context,{arguments}) => GHGoodsList(),
  '/GHGoodsDetails': (context,{arguments}) => GHGoodsDetails(arguments:arguments),

};

/// 固定写法不需要改动
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
