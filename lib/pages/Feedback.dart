import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yssqc/common/apis/Feedback.dart';
import 'package:yssqc/common/util/utils.dart';
import 'package:yssqc/common/widgets/appbarWidget.dart';
import 'package:yssqc/common/widgets/toast.dart';
import 'package:yssqc/global.dart';
import 'package:yssqc/model/Feedback.dart';
import 'package:yssqc/model/responseModel.dart';
import 'package:yssqc/common/router/router.gr.dart';

class FeedbackPage extends StatefulWidget {
  final List<String> textList;
  final String times;
  final String monthText;

  FeedbackPage(this.textList, this.times, this.monthText);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  var _dropDownValue;
  var _controllerTextField = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWidget(context, '反馈'),
      body: _getFeedbackWidget(),
    );
  }

  //获取整体布局
  _getFeedbackWidget() {
    return Container(
        child: ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            _getFirstWidget(),
            _getInputWidget(),
            _getButtonWidget(),
          ],
        ),
      ],
    ));
  }

  _getFirstWidget() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(
                  sySetWidth(24), sySetWidth(50), sySetWidth(25), 0),
              width: sySetWidth(280),
              height: sySetWidth(82),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: Text('请选择'),
                  value: _dropDownValue,
                  items: _getSelectItems(),
                  onChanged: (value) {
                    setState(() {
                      _dropDownValue = value;
                    });
                  },
                ),
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(205, 205, 205, 1),
                      width: sySetWidth(1))),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(
                  sySetWidth(25), sySetWidth(50), sySetWidth(24), 0),
              width: sySetWidth(280),
              height: sySetWidth(82),
              child: Text(widget.monthText),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(205, 205, 205, 1),
                      width: sySetWidth(1))),
            ),
          )
        ],
      ),
    );
  }

  _getInputWidget() {
    return Container(
        height: sySetHeight(300),
        padding: EdgeInsets.fromLTRB(
            sySetWidth(20), 0, sySetWidth(20), sySetWidth(10)),
        margin: EdgeInsets.fromLTRB(
            sySetWidth(24), sySetWidth(39), sySetWidth(24), 0),
        decoration: BoxDecoration(
          border: Border.all(
              color: Color.fromRGBO(205, 205, 205, 1), width: sySetWidth(1)),
        ),
        child: TextField(
          controller: _controllerTextField,
          maxLines: 5,
          decoration: InputDecoration(
              hintText: '提出您的建议...',
              hintStyle: TextStyle(
                  fontSize: sySetFontSize(28),
                  color: Color.fromRGBO(153, 153, 153, 1)),
              labelStyle: TextStyle(
                  fontSize: sySetFontSize(28),
                  color: Color.fromRGBO(51, 51, 51, 1)),
              border: InputBorder.none),
        ));
  }

  _getButtonWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          sySetWidth(30), sySetWidth(140), sySetWidth(30), 0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: sySetHeight(96),
              child: FlatButton(
                child: Text(
                  '提交',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: sySetFontSize(32),
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                color: Color.fromRGBO(246, 159, 0, 1),
                onPressed: () {
                  _submitAll();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  //获取下拉选项
  _getSelectItems() {
    if (widget.textList.length != 0) {
      List<DropdownMenuItem> itemList = [];
      var index = 0;
      widget.textList.forEach((element) {
        var t = DropdownMenuItem(
          child: Container(
            width: sySetWidth(200),
            alignment: Alignment.center,
            child: Text(element, overflow: TextOverflow.ellipsis, maxLines: 1),
          ),
          value: element,
        );
        itemList.add(t);
      });
      return itemList;
    }
  }

  _submitAll() async {
    if (_dropDownValue == null) {
      showError(context, text: '请选择工资类型', times: 1000);
      return;
    }
    if (_controllerTextField.value.text.length == 0) {
      showError(context, text: '请输入您的建议', times: 1000);
      return;
    }
    showLoading(context, "正在提交");
    FeedbackRequestEntity feedbackRequestEntity = FeedbackRequestEntity(
      cid: Global.companyId,
      wagesText: _dropDownValue,
      content: _controllerTextField.value.text,
      times: widget.times,
    );
    ResponseModel responseModel = await FeedbackApi.postData(
        context: context, feedbackRequestEntity: feedbackRequestEntity);
    if (responseModel.error == 200) {
      Navigator.pop(context);
      showSuccessRoute(context, _gotoCenter,
          text: responseModel.message, times: 500);
    } else {
      showError(responseModel.message);
    }
  }

  _gotoCenter() {
    ExtendedNavigator.rootNavigator.pushTabsRoute(index: 2);
  }
}
