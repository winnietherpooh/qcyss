import 'package:flutter/material.dart';
import 'tabspage/Home.dart';
import 'tabspage/Center.dart';
import 'tabspage/News.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yssqc/common/utils.dart';
class Taps extends StatefulWidget {
  final int index;
  Taps({this.index});
  @override
  _TapsState createState() => _TapsState();
}

class _TapsState extends State<Taps> {
  int _currentIndexTemp;
  List pageList = [
    HomePage(),
    NewsPage(),
    CenterPage(),
  ];
  @override
  void initState() {
    this._currentIndexTemp = widget.index ?? 0;
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334-40);
    return Scaffold(

      body: this.pageList[this._currentIndexTemp],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndexTemp,
        iconSize: sySetWidth(30),
        //tab大小
        type: BottomNavigationBarType.fixed,
        //允许设置超过三个的tab按钮,
        fixedColor: Colors.orange,
        //选中的tab颜色
        onTap: (index) {
          setState(() {
            _currentIndexTemp = index;
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
