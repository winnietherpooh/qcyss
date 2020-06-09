import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yss/Config.dart';
import 'package:yss/common/util/screen.dart';
import 'package:yss/data/map.dart';
import 'package:yss/model/NewsModel.dart';
import 'package:yss/pages/banner.dart';

class Test2Page extends StatefulWidget {
  @override
  _Test2PageState createState() => _Test2PageState();
}

class _Test2PageState extends State<Test2Page> {
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
    print('---------------------');
    var api = Config.domain +
        'index.php?m=Home&c=Newapi&a=newList&cid=${Config.companyId}';
    var result = await Dio().get(api);
    print(result);
    var getData = json.decode(result.data);
    var NewsResult = NewsModel.fromJson(getData);
    setState(() {
      if (_touchType == 0 || _touchType == 1) {
        // this._dataList = NewsResult.data;
        this._dataList.addAll(NewsResult.data);
      } else {
        this._dataList.addAll(NewsResult.data);
      }
    });

    print(_dataList.length);
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
                  height: sySetHeight(40),
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
    return Column(
      children: <Widget>[
        Container(
          height: sySetHeight(270),
          width: double.infinity,
          color: Color.fromRGBO(255, 255, 255, 1),
          margin: EdgeInsets.only(left: sySetWidth(24)),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(sySetWidth(24), sySetHeight(45), 0, sySetHeight(45)),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Image.network(
                  this._dataList[index].img,
                  width: sySetWidth(270),
                  height: sySetWidth(180),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(
                          sySetWidth(20), sySetHeight(60), sySetWidth(48), 0),
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
                      padding: EdgeInsets.fromLTRB(
                          sySetWidth(20), sySetHeight(30), sySetWidth(48), 0),
                      child: Text(
                        this._dataList[index].content,
                        style: TextStyle(
                          fontSize: sySetFontSize(26),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          0, sySetHeight(6), sySetWidth(44), 0),
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
    );
  }
}
