import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yss/pages/Feedback.dart';
import 'package:yss/pages/FeedbackList.dart';
import 'package:yss/pages/NewsInfo.dart';
import 'package:yss/pages/SalaryInfo.dart';
import 'package:yss/pages/SetList.dart';
import 'package:yss/pages/Sign.dart';
import 'package:yss/pages/SignView.dart';
import 'package:yss/pages/index.dart';
import 'package:yss/pages/login.dart';
import 'package:yss/pages/setPasswd.dart';
import 'package:yss/tabs/Taps.dart';
import 'package:yss/tabs/tabspage/Home.dart';

//动画
Widget zoomInTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return ScaleTransition(scale: animation, child: child);
}
//flutter packages pub run build_runner build
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

  SalaryInfoPage salaryInfoPageRoute;

  SignPage signPageRoute;

  SignViewPage signViewPageRoute;

  FeedbackPage feedbackPageRoute;

  FeedbackListPage feedbackListPageRoute;


}
