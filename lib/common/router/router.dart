import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yss/pages/NewsInfo.dart';
import 'package:yss/pages/SetList.dart';
import 'package:yss/pages/index.dart';
import 'package:yss/pages/login.dart';
import 'package:yss/pages/setPasswd.dart';
import 'package:yss/tabs/Taps.dart';

//动画
Widget zoomInTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return ScaleTransition(scale: animation, child: child);
}

@MaterialAutoRouter(generateNavigationHelperExtension: true)
class $AppRouter {
  @initial //首页注解
  IndexPage indexPageRoute;

  Taps tabsRoute;

  @CustomRoute(transitionsBuilder: zoomInTransition)
  LoginPage loginPageRoute;

  NewsInfoPage newsInfoPageRoute;

  SetListPage setListPageRoute;

  SetPassWdPage setPassWdPageRoute;


}
