// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:yss/tabs/Taps.dart';
import 'package:yss/pages/login.dart';
import 'package:yss/pages/NewsInfo.dart';
import 'package:yss/pages/SetList.dart';
import 'package:yss/pages/setPasswd.dart';

abstract class Routes {
  static const tabsRoute = '/';
  static const loginPageRoute = '/login-page-route';
  static const newsInfoPageRoute = '/news-info-page-route';
  static const setListPageRoute = '/set-list-page-route';
  static const setPassWdPageRoute = '/set-pass-wd-page-route';
  static const all = {
    tabsRoute,
    loginPageRoute,
    newsInfoPageRoute,
    setListPageRoute,
    setPassWdPageRoute,
  };
}

class AppRouter extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<AppRouter>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.tabsRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => Taps(),
          settings: settings,
        );
      case Routes.loginPageRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginPage(),
          settings: settings,
        );
      case Routes.newsInfoPageRoute:
        if (hasInvalidArgs<NewsInfoPageArguments>(args)) {
          return misTypedArgsRoute<NewsInfoPageArguments>(args);
        }
        final typedArgs =
            args as NewsInfoPageArguments ?? NewsInfoPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              NewsInfoPage(key: typedArgs.key, id: typedArgs.id),
          settings: settings,
        );
      case Routes.setListPageRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SetListPage(),
          settings: settings,
        );
      case Routes.setPassWdPageRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SetPassWdPage(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//NewsInfoPage arguments holder class
class NewsInfoPageArguments {
  final Key key;
  final String id;
  NewsInfoPageArguments({this.key, this.id});
}

// *************************************************************************
// Navigation helper methods extension
// **************************************************************************

extension AppRouterNavigationHelperMethods on ExtendedNavigatorState {
  Future pushTabsRoute() => pushNamed(Routes.tabsRoute);

  Future pushLoginPageRoute() => pushNamed(Routes.loginPageRoute);

  Future pushNewsInfoPageRoute({
    Key key,
    String id,
  }) =>
      pushNamed(
        Routes.newsInfoPageRoute,
        arguments: NewsInfoPageArguments(key: key, id: id),
      );

  Future pushSetListPageRoute() => pushNamed(Routes.setListPageRoute);

  Future pushSetPassWdPageRoute() => pushNamed(Routes.setPassWdPageRoute);
}
