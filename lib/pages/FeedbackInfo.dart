import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:yss/common/apis/Feedback.dart';
import 'package:yss/common/apis/News.dart';
import 'package:yss/common/util/screen.dart';
import 'package:yss/common/utils.dart';
import 'package:yss/model/FeedbackInfoModel.dart';
import 'package:yss/model/NewsInfoModel.dart';


class FeedbackInfoPage extends StatefulWidget {
  final String id;

  FeedbackInfoPage({Key key, this.id}) : super(key: key);

  @override
  _FeedbackInfoPageState createState() =>
      _FeedbackInfoPageState();
}

class _FeedbackInfoPageState extends State<FeedbackInfoPage> {

  Map arguments;
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
        this._title = feedbackInfoModel.data.content;
        this._content = feedbackInfoModel.data.backCont;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(arguments);
    return Scaffold(
      appBar: AppBar(
        title: Text('反馈详情'),
        centerTitle: true,
      ),
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
                  maxLines: 1,
                  overflow: TextOverflow.visible,
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
