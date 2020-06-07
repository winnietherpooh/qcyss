import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yss/pages/banner.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,  //去掉TAB栏箭头
        title: Text('优算师'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          BannerPage(),
          RaisedButton(
              child: Text('跳转到测试页'),
              onPressed: (){
                Navigator.pushNamed(context, '/test2');
              }),
          RaisedButton(
              child: Text('跳转到测试页'),
              onPressed: (){
                Navigator.pushNamed(context, '/setlist');
              })
        ],
      ),
    );
  }
}
