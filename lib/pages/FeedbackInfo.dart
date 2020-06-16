import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yss/common/apis/Feedback.dart';
import 'package:yss/common/util/screen.dart';
import 'package:yss/common/utils.dart';
import 'package:yss/common/widgets/appbarWidget.dart';
import 'package:yss/model/FeedbackInfoModel.dart';
import 'package:yss/common/router/router.gr.dart';

class FeedbackInfoPage extends StatefulWidget {
  final String id;

  FeedbackInfoPage({Key key, this.id}) : super(key: key);

  @override
  _FeedbackInfoPageState createState() =>
      _FeedbackInfoPageState();
}

class _FeedbackInfoPageState extends State<FeedbackInfoPage> {

  var _title="";
  var _content="";

  @override
  void initState() {
    _getData();
  }
  _FeedbackInfoPageState();

  _getData() async {
    FeedbackInfoModel feedbackInfoModel = await FeedbackApi.getInfo(
        context: context,
        id: widget.id
    );
    if(feedbackInfoModel.error == 200){
      setState(() {
        this._title = feedbackInfoModel.data.content ?? "";
        this._content = feedbackInfoModel.data.backCont ?? "";
      });
    }
  }
  _gobackReflush(){
    ExtendedNavigator.rootNavigator.pushFeedbackListPageRoute();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWidget(context,'反馈详情',reflush: _gobackReflush),
      body: Container(
        width: double.infinity,
          child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(
                    sySetWidth(24), sySetHeight(50), sySetHeight(24), 0),
                child: Text(
                  _title,
                  style: TextStyle(
                      color: Color.fromRGBO(51, 51, 51, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: sySetFontSize(32)),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    sySetWidth(24), sySetHeight(30), sySetHeight(24), 0),
                child: Text(
                  '回复: ${_content}',
                  style: TextStyle(
                      color: Color.fromRGBO(102, 102, 102, 1),
                      fontSize: sySetFontSize(28)),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }

}
