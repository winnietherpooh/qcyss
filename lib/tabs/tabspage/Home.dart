import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yss/common/apis/Salary.dart';
import 'package:yss/common/util/screen.dart';
import 'package:yss/common/widgets/CustomRadioButton.dart';
import 'package:yss/common/widgets/appbarWidget.dart';
import 'package:yss/model/SalaryModel.dart';
import 'package:yss/pages/banner.dart';
import 'package:yss/common/router/router.gr.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController sqSalary = TextEditingController();
  TextEditingController _insurance = TextEditingController(); //保险
  TextEditingController _accumulationFund = TextEditingController(); //公积金
  TextEditingController _education = TextEditingController(); //子女教育
  var _educationPercent = 0; //子女教育百分比
  var _adultEducationPercent = 0; //继续教育百分比
  TextEditingController _medical = TextEditingController(); //医疗
  var _housingLoans = 0; //住房贷款
  var _housingFund = 0;

  ///住房基金
  var _supportingElderly = 0; //赡养老人

  _submitAll(){
    SalaryRequestModel salaryRequestModel = SalaryRequestModel(
        salary: this.sqSalary.value.text ?? '0',
        insurance: this._insurance.value.text,
        accumulationFund: this._accumulationFund.value.text,
        childrenNum: this._education.value.text,
        childrenEducation: this._educationPercent.toString(),
        adultEducation: this._adultEducationPercent.toString(),
        medicalSeriousIllness: this._medical.value.text,
        houseLoan: this._housingLoans.toString(),
        houseFund: this._housingFund.toString(),
        supportOld: this._supportingElderly.toString()
    );
    print(this.sqSalary.value.text);
    ExtendedNavigator.rootNavigator.pushSalaryInfoPageRoute(salaryRequestModel: salaryRequestModel);
  }

  _resetAll() {
    setState(() {
      _insurance = TextEditingController();
      sqSalary = TextEditingController();
      _accumulationFund = TextEditingController();
      _education = TextEditingController();
      _medical = TextEditingController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWidget('优算师',isShowIcon: false),
      body: ListView(
        children: <Widget>[
          BannerPage(),
//          SizedBox(height: sySetHeight(20),),
          _getTopTitleWidget('个税计算器（金额最多2位小数）'),
          _getCenterMsgHadIconWidget('税前工资', '请输入税前工资', sqSalary),
          _getCenterMsgWidthoutIconWidget(
              '各项社会保险', '请输入各项社会保险金额', _insurance),
          _getCenterMsgWidthoutIconWidget(
              '五险一金', '请输入公积金', _accumulationFund),
          _getTopTitleWidget('专项抵扣'),
          _getCenterMsgHadButtonListWidget(
              '子女教育', '请输入人数', this._education, this._educationPercent,
              ['50%', '100%'], [1, 2]),
          _getCenterMsgHadButtonListWithoutLabelWidget(
              '继续教育', this._adultEducationPercent, ['教育期间', '取证当年'], [1, 2]),
          _getTopTitleWidget('教育期间400/月，取证当年300/月', height: 50),
          _getCenterMsgHadIconWidget('大病医疗', '请输入金额', this._medical),
          _getCenterMsgHadButtonListWithoutLabelWidget(
              '住房贷款', this._housingLoans, ['50%', '100%'], [1, 2]),
          _getCenterMsgHadButtonListWithoutLabelWidget(
              '住房基金', this._housingFund, ['800', '1000', '1500'], [1, 2, 3]),
          _getCenterMsgHadButtonListWithoutLabelWidget(
              '赡养老人', this._supportingElderly, ['非独生子女', '独生子女'], [1, 2]),
          _getTopTitleWidget('独生子女2000，非独生子女自定义', height: 50),
          SizedBox(height: sySetHeight(20),),
          _getBottomButton(),
          SizedBox(height: sySetHeight(20),),
        ],
      ),
    );
  }

  _getBottomButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.fromLTRB(sySetWidth(25), 0, sySetWidth(25), 0),
              height: sySetHeight(92),
              child: FlatButton(
                color: Color.fromRGBO(249, 158, 5, 1),
                child: Text('计算', style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: sySetFontSize(32)
                ),),
                onPressed: _submitAll,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.fromLTRB(sySetWidth(25), 0, sySetWidth(25), 0),
              height: sySetHeight(92),
              child: FlatButton(
                color: Color.fromRGBO(205, 205, 205, 1),
                child: Text('重置', style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: sySetFontSize(32)
                ),),
                onPressed: (){
                  setState(() {
                    _resetAll();
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  //获取顶部标题布局
  _getTopTitleWidget(String title, {double height = 70}) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: sySetWidth(24)),
      color: Color.fromRGBO(240, 240, 242, 1),
      height: sySetHeight(height),
      child: Text(
        '${title}',
        style: TextStyle(
            color: Color.fromRGBO(249, 158, 5, 1), fontSize: sySetFontSize(24)),
      ),
    );
  }

  //带图标的文本输入框
  _getCenterMsgHadIconWidget(String label, String floatLabel, var myEditController) {
    return Container(
      height: sySetHeight(110),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: sySetWidth(2),
            color: Color.fromRGBO(229, 229, 229, 1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: sySetWidth(24)),
            child: Text(
              label,
              style: TextStyle(
                color: Color.fromRGBO(51, 51, 51, 1),
                fontSize: sySetFontSize(30),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: sySetWidth(20)),
            child: Image.asset(
              'images/warning.png',
              width: sySetWidth(32),
              height: sySetWidth(32),
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: sySetWidth(24)),
              child: TextField(
                controller: myEditController,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: '${floatLabel}',
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(153, 153, 153, 1),
                        fontSize: sySetFontSize(28)
                    ),
                    labelStyle: TextStyle(
                      fontSize: sySetFontSize(28),
                    ),
                    border: InputBorder.none),
              ),
            ),
          )
        ],
      ),
    );
  }

  //不带图标的文本输入框
  _getCenterMsgWidthoutIconWidget(String label, String floatLabel,
      var Controller) {
    return Container(
      height: sySetHeight(110),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: sySetWidth(2),
            color: Color.fromRGBO(229, 229, 229, 1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: sySetWidth(24)),
            child: Text(
              label,
              style: TextStyle(
                color: Color.fromRGBO(51, 51, 51, 1),
                fontSize: sySetFontSize(30),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(right: sySetWidth(24)),
              child: TextField(
                controller: Controller,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: '${floatLabel}',
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(153, 153, 153, 1),
                        fontSize: sySetFontSize(28)
                    ),
                    labelStyle: TextStyle(
                      fontSize: sySetFontSize(28),
                    ),
                    border: InputBorder.none),
              ),
            ),
          )
        ],
      ),
    );
  }

  //带按钮组的文本输入框
  _getCenterMsgHadButtonListWidget(String label, String floatLabel,
      var Controller, var percent, List<String> itemLabel, List item) {
    return Container(
      height: sySetHeight(110),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: sySetWidth(2),
            color: Color.fromRGBO(229, 229, 229, 1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: sySetWidth(24)),
            child: Text(
              label,
              style: TextStyle(
                color: Color.fromRGBO(51, 51, 51, 1),
                fontSize: sySetFontSize(30),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: sySetWidth(20)),
            child: Image.asset(
              'images/warning.png',
              width: sySetWidth(32),
              height: sySetWidth(32),
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: sySetWidth(24)),
              child: TextField(
                controller: Controller,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: '${floatLabel}',
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(153, 153, 153, 1),
                        fontSize: sySetFontSize(28)
                    ),
                    labelStyle: TextStyle(
                      fontSize: sySetFontSize(28),
                    ),
                    border: InputBorder.none),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: CustomRadioButton(
              enableShape: false,
              elevation: 0,
              buttonColor: Theme
                  .of(context)
                  .canvasColor,
              buttonLables: itemLabel,
              buttonValues: item,
              radioButtonValue: (value) {
                setState(() {
                  percent = value;
                });
              },
              selectedColor: Theme
                  .of(context)
                  .accentColor,
            ),
          )
        ],
      ),
    );
  }

  _getCenterMsgHadButtonListWithoutLabelWidget(String label, var percent,
      List<String> itemLabel, List item) {
    return Container(
      height: sySetHeight(110),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: sySetWidth(2),
            color: Color.fromRGBO(229, 229, 229, 1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: sySetWidth(24)),
            child: Text(
              label,
              style: TextStyle(
                color: Color.fromRGBO(51, 51, 51, 1),
                fontSize: sySetFontSize(30),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: sySetWidth(20)),
            child: Image.asset(
              'images/warning.png',
              width: sySetWidth(32),
              height: sySetWidth(32),
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(''),
          ),
          Expanded(
            flex: 7,
            child: CustomRadioButton(
              enableShape: false,
              elevation: 0,
              buttonColor: Theme
                  .of(context)
                  .canvasColor,
              buttonLables: itemLabel,
              buttonValues: item,
              radioButtonValue: (value) {
                setState(() {
                  percent = value;
                });
              },
              selectedColor: Theme
                  .of(context)
                  .accentColor,
            ),
          )
        ],
      ),
    );
  }
}
