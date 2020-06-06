import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yss/common/utils.dart';

class CenterPage extends StatefulWidget {
  @override
  _CenterPageState createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  var _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('个人中心'),
        centerTitle: true,
      ),
      body: _getAllWidget(),
    );
  }

  _getAllWidget() {
    return Container(
      color: AppColors.mainBgColor,
      child: ListView(
        controller: this._controller,
        children: <Widget>[
          _getHeadWidget(),
          _getBasyPayWidget('未确定发放工资明细'),
          _getBasyPayWidget('未确定发放奖金明细'),
        ],
      ),
    );
  }

  //顶部布局
  _getHeadWidget() {
    return Container(
      height: sySetHeight(340),
      width: double.infinity,
      color: AppColors.primaryElement,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(
                      sySetWidth(24), sySetHeight(80), 0, 0),
                  width: sySetWidth(110),
                  height: sySetHeight(110),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(sySetWidth(55)),
                    image: DecorationImage(
                        image: NetworkImage(
                            "http://cdn.toolvip.com//imagedemo/2.jpg"),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      sySetWidth(20), sySetHeight(90), 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          '张三丰',
                          style: TextStyle(
                              fontSize: sySetFontSize(32),
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainFontColor),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: sySetHeight(30)),
                        child: Text(
                          '厂领导',
                          style: TextStyle(
                              fontSize: sySetFontSize(28),
                              color: AppColors.mainFontColor),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: sySetHeight(20)),
                        child: Text(
                          '长庆油田采油厂领导',
                          style: TextStyle(
                              fontSize: sySetFontSize(28),
                              color: AppColors.mainFontColor),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'images/setting.png',
                          width: sySetWidth(40),
                          height: sySetHeight(40),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            sySetWidth(60), sySetHeight(30), sySetWidth(30), 0),
                        child: Image.asset(
                          'images/notice.png',
                          width: sySetWidth(40),
                          height: sySetHeight(40),
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0, sySetHeight(36), sySetWidth(26), 0),
                  child: Text(
                    '工号：100001',
                    style: TextStyle(
                        fontSize: sySetFontSize(26),
                        color: AppColors.mainFontColor),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //未确定工资布局
  _getBasyPayWidget(String title) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: sySetHeight(30)),
      child: Column(
        children: <Widget>[
          Container(
            height: sySetHeight(88),
            padding: EdgeInsets.only(left: sySetWidth(24)),
            alignment: Alignment.centerLeft,
            color: AppColors.mainFontColor,
            // color: Color.fromRGBO(255, 255, 255, 1),
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sySetFontSize(30),
                  color: Color.fromRGBO(246, 159, 0, 1)),
            ),
          ),
          Container(
            child: ListView(
              controller: this._controller,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                _getBasePayAllItem(),
                _getBasePayAllItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //未确认工资明细的每一项布局
  _getBasePayListItemWidget() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
                  color: Color.fromRGBO(248, 248, 248, 1),
                  width: sySetWidth(2)))),
      width: sySetWidth(200),
      height: sySetHeight(220),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: sySetWidth(200),
            height: sySetHeight(100),
            color: AppColors.mainColor,
            child: Text(
              '姓名',
              style: TextStyle(
                color: AppColors.mainFontColor,
                fontSize: sySetFontSize(28),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: sySetWidth(200),
            height: sySetHeight(100),
            color: AppColors.mainFontColor,
            child: Text(
              '2658',
              style: TextStyle(
                color: Color.fromRGBO(51, 51, 51, 1),
                fontSize: sySetFontSize(28),
              ),
            ),
          )
        ],
      ),
    );
  }

  _getBasePayAllItem() {
    return Container(
      height: sySetHeight(220),
      child: ListView(
        scrollDirection: Axis.horizontal,
        controller: this._controller,
        children: <Widget>[
          _getBasePayListItemWidget(),
          _getBasePayListItemWidget(),
          _getBasePayListItemWidget(),
          _getBasePayListItemWidget(),
          _getBasePayListItemWidget(),
          _getBasePayListItemWidget(),
          _getBasePayListItemWidget(),
          _getBasePayListItemWidget(),
          _getBasePayListItemWidget(),
          _getBasePayListItemWidget(),
          _getBasePayListItemWidget(),
        ],
      ),
    );
  }
}
