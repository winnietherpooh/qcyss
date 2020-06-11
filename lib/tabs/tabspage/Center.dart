import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yss/common/router/router.gr.dart';
import 'package:yss/common/utils.dart';
import 'package:yss/global.dart';

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
          _getSearchList(),
        ],
      ),
    );
  }

  //顶部布局
  _getHeadWidget() {
    return Container(
      height: sySetHeight(300),
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
                  height: sySetWidth(110),
                  decoration: BoxDecoration(
                    //242
                    border: Border.all(
                      color: Color.fromRGBO(242, 242, 242, 1),
                      width: sySetWidth(2),
                    ),
                    borderRadius: BorderRadius.circular(
                      sySetWidth(55),
                    ),
                    image: DecorationImage(
                        image: NetworkImage("${Global.profile.userPortrait}"),
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
                          '${Global.profile.userName}',
                          style: TextStyle(
                              fontSize: sySetFontSize(32),
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainFontColor),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: sySetHeight(30)),
                        child: Text(
                          '${Global.profile.userPosition}',
                          style: TextStyle(
                              fontSize: sySetFontSize(28),
                              color: AppColors.mainFontColor),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: sySetHeight(20)),
                        child: Text(
                          '${Global.profile.dName}${Global.profile.userPosition}',
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
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          iconSize: sySetFontSize(40),
                          icon: ClipOval(
                            child: Image.asset(
                              'images/setting.png',
                              width: sySetWidth(44),
                              height: sySetWidth(44),
                              fit: BoxFit.fill,
                            ),
                          ),
                          onPressed: () {
                            //Navigator.pushNamed(context, '/setlist');
                            ExtendedNavigator.rootNavigator
                                .pushNamed(Routes.setListPageRoute);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            sySetWidth(0), sySetHeight(30), sySetWidth(30), 0),
                        child: IconButton(
                          icon: ClipOval(
                            child: Image.asset(
                              'images/notice.png',
                              width: sySetWidth(44),
                              height: sySetWidth(44),
                              fit: BoxFit.fill,
                            ),
                          ),
                          onPressed: () {
                            ExtendedNavigator.rootNavigator
                                .pushNamed(Routes.setListPageRoute);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0, sySetHeight(36), sySetWidth(26), 0),
                  child: Text(
                    '工号：${Global.profile.account}',
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

  //获取工资奖金列表
  _getBasePayAllItem() {
    return Container(
      height: sySetHeight(200),
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

  //搜索布局
  _getSearchList() {
    return Container(
//      width: double.infinity,
//      height: sySetHeight(148),
      child: Column(
        children: <Widget>[
          _getSearchTitleWidget(),
          _getBasePayAllItem(),
          _getBasePayAllItem(),
        ],
      ),
    );
  }

  //搜索布局表头
  _getSearchTitleWidget() {
    return Container(
      color: AppColors.mainFontColor,
      height: sySetHeight(148),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: sySetWidth(26)),
            width: sySetWidth(160),
            height: sySetHeight(76),
            child: TextField(
              maxLines: 1,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.bottom,
              style: TextStyle(
                  fontSize: sySetFontSize(28),
                  color: Color.fromRGBO(153, 153, 153, 1)),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(232, 232, 232, 1),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(1),
                  ),
                ),
                hintText: '2020-04',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(1),
                  ),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(232, 232, 232, 1),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                sySetWidth(12), sySetHeight(0), sySetWidth(12), 0),
            width: sySetWidth(26),
            height: sySetHeight(2),
            child: Image.asset(
              'images/line.png',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: sySetWidth(160),
            height: sySetHeight(76),
            child: TextField(
              maxLines: 1,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.bottom,
              style: TextStyle(
                  fontSize: sySetFontSize(28),
                  color: Color.fromRGBO(153, 153, 153, 1)),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(232, 232, 232, 1),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(1),
                  ),
                ),
                hintText: '2020-04',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(1),
                  ),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(232, 232, 232, 1),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: sySetWidth(12)),
                  child: Text(
                    '类别',
                    style: TextStyle(
                        fontSize: sySetFontSize(28),
                        color: Color.fromRGBO(153, 153, 153, 1)),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 0),
                  child: Image.asset(
                    'images/select.png',
                    width: sySetWidth(44),
                    height: sySetWidth(44),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.fromLTRB(
                      sySetWidth(40), sySetHeight(0), sySetWidth(20), 0),
                  child: Image.asset(
                    'images/search.png',
                    fit: BoxFit.fill,
                    width: sySetWidth(44),
                    height: sySetWidth(44),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
