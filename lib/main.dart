import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yss/common/router/router.gr.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false, //去掉debug的图标
      builder: ExtendedNavigator<AppRouter>(
        initialRoute: Routes.tabsRoute,
        router: AppRouter(),
       // guards: [AuthGuard()],
      ),
    );
  }
}
