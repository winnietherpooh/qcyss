import 'package:flutter/material.dart';
import 'tabspage/Home.dart';
import 'tabspage/Center.dart';
import 'tabspage/News.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yss/common/utils.dart';
class Taps extends StatefulWidget {
  @override
  _TapsState createState() => _TapsState();
}

class _TapsState extends State<Taps> {
  int currentIndexTemp = 0;
  List pageList = [
    HomePage(),
    NewsPage(),
    CenterPage(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334-40);
    return Scaffold(

      body: this.pageList[this.currentIndexTemp],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this.currentIndexTemp,
        iconSize: sySetWidth(30),
        //tab大小
        type: BottomNavigationBarType.fixed,
        //允许设置超过三个的tab按钮,
        fixedColor: Colors.orange,
        //选中的tab颜色
        onTap: (index) {
          setState(() {
            currentIndexTemp = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'images/home.png',
                width: sySetWidth(40),
                height: sySetWidth(40),
                fit: BoxFit.fill,
              ),
              title: Text(
                "首页",
                style: TextStyle(fontSize: sySetFontSize(20)),
              ),
              activeIcon: Image.asset(
                'images/home-select.png',
                width: sySetWidth(40),
                height: sySetWidth(40),
                fit: BoxFit.fill,
              )),
          BottomNavigationBarItem(
              icon: Image.asset(
                'images/news.png',
                width: sySetWidth(40),
                height: sySetWidth(40),
                fit: BoxFit.fill,
              ),
              title: Text(
                '新闻',
                style: TextStyle(fontSize: sySetFontSize(20)),
              ),
              activeIcon: Image.asset(
                'images/news-select.png',
                width: sySetWidth(40),
                height: sySetWidth(40),
                fit: BoxFit.fill,
              )),
          BottomNavigationBarItem(
              icon: Image.asset(
                'images/center.png',
                width: sySetWidth(40),
                height: sySetWidth(40),
                fit: BoxFit.fill,
              ),
              title: Text(
                '个人中心',
                style: TextStyle(fontSize: sySetFontSize(20)),
              ),
              activeIcon: Image.asset(
                'images/center-select.png',
                width: sySetWidth(40),
                height: sySetWidth(40),
                fit: BoxFit.fill,
              )),
        ],
      ),
    );
  }
}
