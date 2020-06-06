import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yss/Config.dart';
import 'package:yss/common/util/screen.dart';
import 'package:yss/data/map.dart';
import 'package:yss/model/NewsModel.dart';
import 'package:yss/pages/banner.dart';
import 'package:date_format/date_format.dart';
class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  List<NewsItemModel> _dataList = new List();
  ScrollController _controller;
  int _touchType = 0;  //0,默认值,1,下拉刷新,2,上拉加载
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _getNewsData(_touchType);
  }


  _getNewsData(_touchType) async{
    print('---------------------');
    var api = Config.domain+'index.php?m=Home&c=Newapi&a=newList&cid=${Config.companyId}';
    var result = await Dio().get(api);
    print(result);
    var getData = json.decode(result.data);
    var NewsResult = NewsModel.fromJson(getData);
    setState(() {
      if(_touchType == 0 || _touchType == 1){
       // this._dataList = NewsResult.data;
        this._dataList.addAll(NewsResult.data);
      }else{
        this._dataList.addAll(NewsResult.data);
      }
    });

    print(_dataList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading:false,
          title: Text('新闻'),
          centerTitle: true,
        ),
        body:  RefreshIndicator(
            onRefresh: (){
              return Future.delayed(Duration(seconds: 1),(){
                print('下拉');
                 setState(() {
                   this._getNewsData(this._touchType);
                 });
              });
            },
          child: Container(
            color: Color.fromRGBO(240, 240, 240, 1),
            child:  ListView(
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
                    shrinkWrap:true,
                    controller: _controller,
                    itemCount: this._dataList.length,
                    itemBuilder: (content,index){
                      return _getNewsItemWidget(index);
                    },
                  ),
                )
              ],
            ),
          ),
        )


    );
  }


  _getNewsItemWidget(index){
    return Column(
      children: <Widget>[
        Container(
          height: sySetHeight(290),
          color: Color.fromRGBO(255, 255, 255, 1),
          padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
          child: Row(
            children: <Widget>[
              Container(
                width: sySetWidth(270),
                height: sySetHeight(180),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                      image: NetworkImage(this._dataList[index].img), fit: BoxFit.cover),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(10, 20, 24, 0),
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
                      padding: EdgeInsets.fromLTRB(10, 15, 24, 0),
                      child: Text(
                        this._dataList[index].content,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 6, 40, 0),
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
