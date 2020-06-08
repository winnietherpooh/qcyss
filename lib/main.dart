import 'package:flutter/material.dart';
import 'routes/route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false, //去掉debug的图标
      initialRoute: '/',  //设置初始化时,显示的页面路由
      onGenerateRoute: onGenerateRoute,
      //routes: routes,
    );
  }
}
