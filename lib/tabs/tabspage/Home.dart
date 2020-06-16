import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yss/common/apis/Salary.dart';
import 'package:yss/common/util/screen.dart';
import 'package:yss/common/widgets/CustomRadioButton.dart';
import 'package:yss/common/widgets/appbarWidget.dart';
import 'package:yss/common/widgets/toast.dart';
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

  String sqgz = '税前工资5000起征';

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
      appBar: getAppBarWidget(context,'优算师',isShowIcon: false),
      body: ListView(
        children: <Widget>[
          BannerPage(),
//          SizedBox(height: sySetHeight(20),),
          _getTopTitleWidget('个税计算器（金额最多2位小数）'),
          _getCenterMsgHadIconWidget('税前工资', '请输入税前工资', sqSalary,1),
          _getCenterMsgWidthoutIconWidget(
              '各项社会保险', '请输入各项社会保险金额', _insurance),
          _getCenterMsgWidthoutIconWidget(
              '五险一金', '请输入公积金', _accumulationFund),
          _getTopTitleWidget('专项抵扣'),
          _getCenterMsgHadButtonListWidget(
              '子女教育', '请输入人数', this._education, this._educationPercent,
              ['50%', '100%'], [1, 2],2),
          _getCenterMsgHadButtonListWithoutLabelWidget(
              '继续教育', this._adultEducationPercent, ['教育期间', '取证当年'], [1, 2],3),
          _getTopTitleWidget('教育期间400/月，取证当年300/月', height: 50),
          _getCenterMsgHadIconWidget('大病医疗', '请输入金额', this._medical,4),
          _getCenterMsgHadButtonListWithoutLabelWidget(
              '住房贷款', this._housingLoans, ['50%', '100%'], [1, 2],5),
          _getCenterMsgHadButtonListWithoutLabelWidget(
              '住房基金', this._housingFund, ['800', '1000', '1500'], [1, 2, 3],6),
          _getCenterMsgHadButtonListWithoutLabelWidget(
              '赡养老人', this._supportingElderly, ['非独生子女', '独生子女'], [1, 2],7),
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
  _getCenterMsgHadIconWidget(String label, String floatLabel, var myEditController,int stringType ) {
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
            child: InkWell(
              child: Image.asset(
                'images/warning.png',
                width: sySetWidth(32),
                height: sySetWidth(32),
                fit: BoxFit.fill,
              ),
              onTap: (){
                showString(stringType);
              },
            )
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
                        fontSize: sySetFontSize(30)
                    ),
                    labelStyle: TextStyle(
                      fontSize: sySetFontSize(30),
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
                        fontSize: sySetFontSize(30)
                    ),
                    labelStyle: TextStyle(
                      fontSize: sySetFontSize(30),
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
      var Controller, var percent, List<String> itemLabel, List item,int stringType) {
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
            child: InkWell(
              child: Image.asset(
                'images/warning.png',
                width: sySetWidth(32),
                height: sySetWidth(32),
                fit: BoxFit.fill,
              ),
              onTap: (){
                showString(stringType);
              },
            )
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
                        fontSize: sySetFontSize(30)
                    ),
                    labelStyle: TextStyle(
                      fontSize: sySetFontSize(30),
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
      List<String> itemLabel, List item, int stringType) {
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
            child: InkWell(
              child: Image.asset(
                'images/warning.png',
                width: sySetWidth(32),
                height: sySetWidth(32),
                fit: BoxFit.fill,
              ),
              onTap: (){
                showString(stringType);
              },
            )
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

  showString(int type){
    String text = "";
    switch(type){
      case 1:
        text="税前工资5000起征";
        break;
      case 2:
        text="纳税人的子女接受全日制学历教育的相关支出，按照每个子女每月1000元的标准定额扣除";
        break;
      case 3:
        text="纳税人在中国境内接受学历（学位）继续教育的支出，在学历（学位）教育期间按照每月400元定额扣除。同一学历（学位）继续教育的扣除期限不能超过48个月。纳税人接受技能人员职业资格继续教育、专业技术人员职业继续教育的支出，在取得相关证书的当年，按照3600元定额扣除。";
        break;
      case 4:
        text="在一个纳税年度内，纳税人发生的基本医保相关的医疗费用支出，扣除医保报销后个人负担（指医保目录范围内的自付部分）累计超过15000元的部分，由纳税人在办理年度汇算清缴时，在80000元限额内据实扣除。";
        break;
      case 5:
        text="纳税人本人或者配偶单独或者共同使用商业银行或者住房公积金个人住房贷款为本人或者其配偶购买中国境住房，发生的首套住房贷款利息支出，在实际发生贷款利息的年度，扣除期限最长不超过240个月。纳税人智能享受一次首套住房贷款的利息扣除。";
        break;
      case 6:
        text="纳税人在主要工作城市没有自有住房而发生的住房租金支出，可以按照以下标准定额扣除：1:直辖市、省会（首府）城市，计划单列市以及国务院确定的其他城市，扣除标准为每月1500元；2:除第一项所列城市以外，市辖区户籍人口超过100万的城市，扣除标准为每月1100元；市辖区户籍人口不超过100万的城市，扣除标准为每月800元。";
        break;
      case 7:
        text="纳税人赡养一位及以上被赡养人的赡养支出，统一按照以下标准定额扣除：1:纳说人为独生子女的，按照每月2000元的标准定额扣除；2:纳税人为非独生子女的，由其兄弟姐妹分摊每月2000元的扣除额度，每人分摊的额度不能超过每月1000元。可以由赡养人均摊或者约定分摊，也可以由被赡养人制定分摊。约定或者制定分摊的须签订书面分摊协议，指定分摊优先于约定分摊。具体分摊方式和额度在一个纳税年度内不能变更。";
        break;
    }
    showNotice(context,text);
  }
}
