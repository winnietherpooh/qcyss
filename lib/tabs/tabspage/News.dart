import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yss/Config.dart';
import 'package:yss/common/apis/News.dart';
import 'package:yss/common/util/function.dart';
import 'package:yss/common/util/screen.dart';
import 'package:yss/model/NewsModel.dart';
import 'package:yss/pages/banner.dart';
import 'package:yss/common/router/router.gr.dart';


class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<NewsItemModel> _dataList = new List();
  ScrollController _controller;
  int _touchType = 0; //0,默认值,1,下拉刷新,2,上拉加载
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _getNewsData(_touchType);
  }

  _getNewsData(_touchType) async {
    NewsModel newsModel = await NewsListApi.getData(
      context: context,
    );
    setState(() {
      if (_touchType == 0 || _touchType == 1) {
        // this._dataList = NewsResult.data;
        this._dataList.addAll(newsModel.data);
      } else {
        this._dataList.addAll(newsModel.data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('新闻'),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 1), () {
              print('下拉');
              setState(() {
                this._getNewsData(this._touchType);
              });
            });
          },
          child: Container(
            color: Color.fromRGBO(240, 240, 240, 1),
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _controller,
              children: <Widget>[
                BannerPage(),
                Container(
                  height: sySetWidth(40),
                ),
                Container(
                  color: Color.fromRGBO(240, 240, 240, 1),
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: _controller,
                    itemCount: this._dataList.length,
                    itemBuilder: (content, index) {
                      return _getNewsItemWidget(index);
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _getNewsItemWidget(index) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Container(
            height: sySetWidth(270),
            color: Color.fromRGBO(255, 255, 255, 1),
            padding: EdgeInsets.fromLTRB(
                sySetWidth(24), sySetHeight(0), sySetWidth(24), 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: sySetWidth(270),
                  height: sySetWidth(180),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                        image: NetworkImage(this._dataList[index].img),
                        fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(
                            sySetWidth(20), sySetWidth(60), 0, 0),
                        child: Text(
                          this._dataList[index].title,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: sySetFontSize(30),
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(
                            sySetWidth(20), sySetHeight(10), sySetWidth(24), 0),
                        //padding: EdgeInsets.all(0),
                        child: Text(
                          CommonFunction.getNewsContent(this._dataList[index].content),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: sySetFontSize(26),
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            0, 0, sySetWidth(14), sySetWidth(24)),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          this._dataList[index].addTime,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: sySetHeight(20),
          )
        ],
      ),
      onTap: (){
            //Navigator.pushNamed(context, '/newsinfo',arguments: {"id": '${this._dataList[index].id}'});
         ExtendedNavigator.rootNavigator.pushNewsInfoPageRoute(id:'${this._dataList[index].id}');

      },
    );
  }
}
