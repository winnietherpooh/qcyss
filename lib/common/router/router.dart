import 'package:auto_route/auto_route_annotations.dart';
import 'package:yss/pages/NewsInfo.dart';
import 'package:yss/pages/SetList.dart';
import 'package:yss/pages/login.dart';
import 'package:yss/pages/setPasswd.dart';
import 'package:yss/tabs/Taps.dart';

@MaterialAutoRouter(generateNavigationHelperExtension: true)
class $AppRouter {
  @initial //首页注解
  Taps tabsRoute;

  LoginPage loginPageRoute;

  NewsInfoPage newsInfoPageRoute;

  SetListPage setListPageRoute;

  SetPassWdPage setPassWdPageRoute;


}
