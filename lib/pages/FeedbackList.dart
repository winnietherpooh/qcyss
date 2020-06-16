import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:yss/common/apis/Feedback.dart';
import 'package:yss/common/util/screen.dart';
import 'package:yss/global.dart';
import 'package:yss/model/Feedback.dart';

class FeedbackListPage extends StatefulWidget {
  @override
  _FeedbackListPageState createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  int page = 1;
  List<Datum> dataList = [];
  //1,下拉,2,上拉
  _getFeedbackList({int type=1}) async {
    FeedbackResponseModel feedbackResponseModel =
        await FeedbackApi.getData(context: context, p: page);
    print(feedbackResponseModel);
    if (feedbackResponseModel.error == 200) {
      setState(() {
        if(type == 1){
          dataList = feedbackResponseModel.data;
        }else{
          if(feedbackResponseModel.mpage < page){
            return ;
          }
          page++;
          dataList.addAll(feedbackResponseModel.data);
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFeedbackList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('反馈'),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 1), () {
              setState(() {
                this._getFeedbackList();
              });
            });
          },
          child: Container(
            color: Global.bgColor,
            child: ListView(
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
        var t = Container(
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
