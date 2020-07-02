import 'package:auto_route/auto_route.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:yssqc/common/apis/Feedback.dart';
import 'package:yssqc/common/util/screen.dart';
import 'package:yssqc/common/widgets/appbarWidget.dart';
import 'package:yssqc/global.dart';
import 'package:yssqc/model/Feedback.dart';
import 'package:yssqc/common/router/router.gr.dart';

class FeedbackListPage extends StatefulWidget {
  @override
  _FeedbackListPageState createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  int page = 1;
  List<Datum> dataList = [];
  ScrollController _controller = ScrollController();
  bool _isHadMore = true;
  bool _flag = true;  //数据是否加载完成

  _gobackReflush(){
    ExtendedNavigator.rootNavigator.pushTabsRoute(index: 2);
  }
  //1,下拉,2,上拉
  _getFeedbackList({int type=1}) async {
    if (!_isHadMore) {
      return;
    }
    FeedbackResponseModel feedbackResponseModel =
        await FeedbackApi.getData(context: context, p: page);
    if (feedbackResponseModel.error == 200) {
      setState(() {
        if(feedbackResponseModel.mpage < page){
          _isHadMore = false;
          return ;
        }
        page++;
        _flag = true;
        if(type == 1){ //下拉
          dataList = feedbackResponseModel.data;
        }else{
          dataList.addAll(feedbackResponseModel.data);
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFeedbackList(type: 1);
    _controller.addListener(() {

      if ((_controller.position.pixels >
          _controller.position.maxScrollExtent - 40)  &&
          _isHadMore  && _flag == true ) {
        //开始加载更多
        _getFeedbackList(type: 2);
        setState(() {
          _flag = false;
        });
      }
    });

  }

  @override
  void deactivate() {
    super.deactivate();
    var bool = ModalRoute.of(context).isCurrent;
    if (bool) {
      setState(() {
        page = 1;
        _isHadMore = true;
        this._getFeedbackList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBarWidget(context,'反馈'),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 1), () {
              setState(() {
                page = 1;
                _isHadMore = true;
                this._getFeedbackList();
              });
            });
          },
          child: Container(
            color: Global.bgColor,
            child: ListView(
              controller: _controller,
              //children: _getListItem(),
              children: _getListItem(),
            ),
          ),
        ));
  }

  _getListItem() {
    List<Widget> itemList = [];
    if (dataList != null) {
      dataList.forEach((element) {
        double width = 26;
        bool isShow = true;
        if (element.backIsable == '2') {
          width = 0;
        }
        if (element.sign == "2") {
          isShow = false;
        }
        var t = InkWell(
          child: Container(
            height: sySetHeight(154),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'images/redStart.png',
                    fit: BoxFit.cover,
                    width: sySetWidth(width),
                    height: sySetHeight(width),
                  ),
                  alignment: Alignment.topRight,
                  height: sySetWidth(20),
                ),
                Container(
                  width: sySetWidth(520),
                  margin:
                  EdgeInsets.fromLTRB(sySetWidth(24), sySetHeight(18), 0, 0),
                  child: Text(
                    '${element.content}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Color.fromRGBO(51, 51, 51, 1),
                        fontSize: sySetFontSize(28)),
                  ),
                ),
                Container(
                    margin:
                    EdgeInsets.fromLTRB(0, sySetHeight(30), sySetWidth(0), 0),
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Offstage(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(
                                sySetWidth(20), 0, sySetWidth(20), 0),
                            padding: EdgeInsets.fromLTRB(sySetWidth(12),
                                sySetHeight(4), sySetWidth(12), sySetHeight(4)),
                            color: Color.fromRGBO(246, 159, 0, 1),
                            child: Text(
                              '已回复',
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 254, 254, 1),
                                  fontSize: sySetFontSize(22)),
                            ),
                          ),
                          offstage: isShow,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(""),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              sySetWidth(20), 0, sySetWidth(20), 0),
                          child: Text(
                            '${element.addTime}',
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontSize: sySetFontSize(24)),
                          ),
                        )
                      ],
                    ))
              ],
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: sySetWidth(2),
                  color: Color.fromRGBO(229, 229, 229, 1),
                ),
              ),
            ),
          ),
          onTap: (){
            ExtendedNavigator.rootNavigator.pushFeedbackInfoPageRoute(id: element.id);
          },
        );
        itemList.add(t);
      });
    } else {
      var t = Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset(
                'images/logo.png',
                width: sySetWidth(260),
                height: sySetWidth(260),
                fit: BoxFit.fill,
              ),
              margin: EdgeInsets.only(top: sySetHeight(318)),
            ),
            Container(
              margin: EdgeInsets.only(top: sySetHeight(60)),
              child: Text(
                '无数据',
                style: TextStyle(
                    color: Color.fromRGBO(153, 153, 153, 1),
                    fontSize: sySetFontSize(28)),
              ),
            )
          ],
        ),
      );
      itemList.add(t);
    }

    return itemList;
  }
}
