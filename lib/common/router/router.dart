import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yssqc/pages/Feedback.dart';
import 'package:yssqc/pages/FeedbackInfo.dart';
import 'package:yssqc/pages/FeedbackList.dart';
import 'package:yssqc/pages/NewsInfo.dart';
import 'package:yssqc/pages/Question.dart';
import 'package:yssqc/pages/SalaryInfo.dart';
import 'package:yssqc/pages/SetList.dart';
import 'package:yssqc/pages/Sign.dart';
import 'package:yssqc/pages/SignView.dart';
import 'package:yssqc/pages/index.dart';
import 'package:yssqc/pages/login.dart';
import 'package:yssqc/pages/setPasswd.dart';
import 'package:yssqc/tabs/Taps.dart';
import 'package:yssqc/tabs/tabspage/Home.dart';

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

  FeedbackInfoPage feedbackInfoPageRoute;

  QuestionPage questionPageRoute;
}
