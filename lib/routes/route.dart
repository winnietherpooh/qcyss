import 'package:flutter/material.dart';
import 'package:yss/tabs//Taps.dart';
import 'package:yss/pages/login.dart';
///////////////////////////////////////
import 'package:yss/test/test.dart';
import 'package:yss/test/test2.dart';
///////////////////////////////////////
import 'package:yss/pages/SetList.dart';
import 'package:yss/pages/setPasswd.dart';
import 'package:yss/pages/NewsInfo.dart';
final routes = {
  '/': (context) => Taps(),
  '/login': (context) => LoginPage(),
  '/setlist': (context) => SetList(),
  '/setpasswd': (context) => SetPassWdPage(),
  '/newsinfo':(context,{arguments})=>NewsInfoPagePage(arguments:arguments),
  '/test': (context) => TestPage(),
  '/test2': (context) => Test2Page(),
};



//固定写法
var onGenerateRoute=(RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    }else{
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context));
      return route;
    }
  }
};