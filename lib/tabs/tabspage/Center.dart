import 'package:auto_route/auto_route.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yssqc/common/apis/SearchSalary.dart';
import 'package:yssqc/common/apis/SignSalary.dart';
import 'package:yssqc/common/router/router.gr.dart';
import 'package:yssqc/common/utils.dart';
import 'package:yssqc/common/widgets/appbarWidget.dart';
import 'package:yssqc/common/widgets/toast.dart';
import 'package:yssqc/global.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:yssqc/model/SearchModel.dart';
import 'package:yssqc/model/SignSalaryRequestModel.dart';
import 'package:yssqc/model/SignSalaryResponseModel.dart';

class CenterPage extends StatefulWidget {
  @override
  _CenterPageState createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  String _format = 'yyyy-MM';
  String TIME_NOW = formatDate(DateTime.now(), ['yyyy','mm']);
  String MIN_DATETIME = '2018-08-01';
  String MAX_DATETIME =
  formatDate(DateTime.now(), ['yyyy', '-', 'mm', '-', 'dd']);
  String INIT_DATETIME =
  formatDate(DateTime.now(), ['yyyy', '-', 'mm', '-', 'dd']);
  DateTime _dateTime;
  var _controller = ScrollController();
  var dateStart = TextEditingController();
  var dateEnd = TextEditingController();

  List<Basepay> basepay = [];
  List<Welfarepay> welfarepay = [];
  bool isShowBaseWidget = true;
  bool isShowWareWidget = true;
  bool isShowLoading = false;
  List<WagesDropdown> dorpDown=[];
  List<List<WagesList>> wagesList = [];
  var _dropDownValue;

  @override
  void initState() {
    super.initState();
     dateStart = TextEditingController(text: TIME_NOW);
     dateEnd = TextEditingController(text: TIME_NOW);
    _dateTime = DateTime.parse(INIT_DATETIME);
    //print(formatDate(DateTime.now(), ['yyyy', '-', 'mm']));
    _getSalaryData();
    _getSearchData();
  }

  _getSalaryData() async {
    SignSalaryResponseModel salaryResponseModel =
        await SignSalaryApi.getData(context: context);
    Data data = salaryResponseModel.data;
    setState(() {
      basepay = data.basepay;
      if (data.basepay.length > 0) {
        isShowBaseWidget = false;
      }
      if (data.welfarepay.length > 0) {
        isShowWareWidget = false;
      }
      welfarepay = data.welfarepay;
      if (isShowBaseWidget == false || isShowWareWidget == false) {
        isShowLoading = true;
      }
      isShowLoading = true;
    });
  }

  _getSearchData() async {
    SearchRequestModel searchRequestModel = SearchRequestModel(
        cid: Global.companyId,
        startTime: dateStart.value.text,
        endTime: dateEnd.value.text,
        type: _dropDownValue);
    SearchModel searchModel = await SearchSalaryApi.getData(
        context: context, searchRequestModel: searchRequestModel);
    print(searchModel.data.wagesList);
    if (searchModel.error == 200) {
     setState(() {
       dorpDown = searchModel.data.wagesDropdown;
       wagesList = searchModel.data.wagesList;
     });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWidget(context,'个人中心',isShowIcon: false),
      body: _getAllWidget(),
    );
  }

  void _showDatePicker(int type) {
    DatePicker.showDatePicker(
      context,
      // onMonthChangeStartWithFirstDate: true,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        confirm: Text('确定', style: TextStyle(color: Colors.black)),
      ),
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.parse(MAX_DATETIME),
      initialDateTime: _dateTime,
      dateFormat: _format,
      //locale: _locale,
      // onClose: () {
      //   print(_dateTime);
      // },
      // onCancel: () {
      //   print(_dateTime);
      // },
      // onChange: (dateTime, List<int> index) {
      //   setState(() {
      //     _dateTime = dateTime;
      //     print(_dateTime);
      //   });
      // },
      onConfirm: (dateTime, List<int> index) {
        print(dateTime);
        setState(() {
          //print(formatDate(dateTime, ['yyyy', '-', 'mm']));
//          print('=====================================');
//          print(formatDate(dateTime, ['yyyy', '-', 'mm']).trim() is String);
//          print('=====================================');
          _dateTime = dateTime;
//          dateStart = TextEditingController();
//          dateStart = TextEditingController();
          if (type == 1) {
            dateStart.text = formatDate(dateTime, ['yyyy', '-', 'mm']).trim();
            //dateStart.text = '2020-05';
          } else {
            dateEnd.text = formatDate(dateTime, ['yyyy', '-', 'mm']).trim();
          }
        });
      },
    );
  }

  _getAllWidget() {
    return Container(
      color: AppColors.mainBgColor,
      child: ListView(
        controller: this._controller,
        children: <Widget>[
          _getHeadWidget(),
          Offstage(
            offstage: isShowLoading,
            child: getLoadingWidget(),
          ),
          Offstage(
            offstage: isShowBaseWidget,
            child: _getBasyPayWidget('未确定发放工资明细', basepay,1),
          ),
          Offstage(
            offstage: isShowWareWidget,
           child:  _getBasyPayWidget('未确定发放奖金明细', welfarepay,2),
          ),
          _getSearchList(),
        ],
      ),
    );
  }

  //顶部布局
  _getHeadWidget() {
    return Container(
      height: sySetHeight(300),
      width: double.infinity,
      color: AppColors.primaryElement,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(
                      sySetWidth(24), sySetHeight(80), 0, 0),
                  width: sySetWidth(110),
                  height: sySetWidth(110),
                  decoration: BoxDecoration(
                    //242
                    border: Border.all(
                      color: Color.fromRGBO(242, 242, 242, 1),
                      width: sySetWidth(2),
                    ),
                    borderRadius: BorderRadius.circular(
                      sySetWidth(55),
                    ),
                    image: DecorationImage(
                        image: NetworkImage("${Global.profile.userPortrait}"),
                        fit: BoxFit.fitWidth),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      sySetWidth(20), sySetHeight(90), 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          '${Global.profile.userName}',
                          style: TextStyle(
                              fontSize: sySetFontSize(32),
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainFontColor),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: sySetHeight(30)),
                        child: Text(
                          '${Global.profile.userPosition}',
                          style: TextStyle(
                              fontSize: sySetFontSize(28),
                              color: AppColors.mainFontColor),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: sySetHeight(20)),
                        child: Text(
                          '${Global.profile.dName}${Global.profile.userPosition}',
                          style: TextStyle(
                              fontSize: sySetFontSize(28),
                              color: AppColors.mainFontColor),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          iconSize: sySetFontSize(40),
                          icon: ClipOval(
                            child: Image.asset(
                              'images/setting.png',
                              width: sySetWidth(44),
                              height: sySetWidth(44),
                              fit: BoxFit.fill,
                            ),
                          ),
                          onPressed: () {
                            //Navigator.pushNamed(context, '/setlist');
                            ExtendedNavigator.rootNavigator
                                .pushNamed(Routes.setListPageRoute);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            sySetWidth(0), sySetHeight(30), sySetWidth(4), 0),
                        child: IconButton(
                          icon: ClipOval(
                            child: Image.asset(
                              'images/notice.png',
                              width: sySetWidth(44),
                              height: sySetWidth(44),
                              fit: BoxFit.fill,
                            ),
                          ),
                          onPressed: () {
                            ExtendedNavigator.rootNavigator
                                .pushNamed(Routes.feedbackListPageRoute);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0, sySetHeight(36), sySetWidth(20), 0),
                  child: Text(
                    '工号：${Global.profile.account}',
                    style: TextStyle(
                        fontSize: sySetFontSize(26),
                        color: AppColors.mainFontColor),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //未确定工资布局
  _getBasyPayWidget(String title, List<dynamic> key, int type) {
    return Container(
      margin: EdgeInsets.only(top: sySetHeight(30)),
      child: Column(
        children: <Widget>[
          Container(
            height: sySetHeight(88),
            padding: EdgeInsets.only(left: sySetWidth(24)),
            alignment: Alignment.centerLeft,
            color: AppColors.mainFontColor,
            // color: Color.fromRGBO(255, 255, 255, 1),
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sySetFontSize(30),
                  color: Color.fromRGBO(246, 159, 0, 1)),
            ),
          ),
          Container(
            child: ListView(
              controller: this._controller,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: _getBasePayAllItem(key, type),
            ),
          ),
        ],
      ),
    );
  }

  //这个返回每一项工资的所有键值对
  //未确认工资明细的每一项布局
  List<Widget> _getBasePayListItemWidget(List value, String sendMonth, int type,
      {String ffrq, List<String> textlist, String monthText}) {
    List<Widget> itemWidget = new List();
    for (var i = 0; i < value.length; i++) {
      var t = Container(
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
                    color: Color.fromRGBO(248, 248, 248, 1),
                    width: sySetWidth(2)))),
        width: sySetWidth(200),
        height: sySetHeight(220),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: sySetWidth(200),
              height: sySetHeight(100),
              color: AppColors.mainColor,
              child: Text(
                '${value[i].name}',
                style: TextStyle(
                  color: AppColors.mainFontColor,
                  fontSize: sySetFontSize(28),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: sySetWidth(200),
              height: sySetHeight(100),
              color: AppColors.mainFontColor,
              child: Text(
                '${value[i].value}',
                style: TextStyle(
                  color: Color.fromRGBO(51, 51, 51, 1),
                  fontSize: sySetFontSize(28),
                ),
              ),
            )
          ],
        ),
      );
      itemWidget.add(t);
    }
    if (itemWidget.length > 0) {
      itemWidget.add(_getItemButton(SignSalaryRequestModel(
          ffrq: ffrq, ffy: sendMonth, welfarename: type)));
      itemWidget.add(_getItemButton(
          SignSalaryRequestModel(
              ffrq: ffrq,
              ffy: sendMonth,
              welfarename: type,
              textList: textlist,
              monthText: monthText),
          buttonColor: Color.fromRGBO(190, 1, 8, 1),
          buttonText: '反馈',
          labelTitle: '反馈',
          type: 2));
    }
    return itemWidget;
  }

  _getItemButton(SignSalaryRequestModel salaryRequestModel,
      {int type = 1,
      Color buttonColor,
      String buttonText = '确认',
      String labelTitle = "签字"}) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
                  color: Color.fromRGBO(248, 248, 248, 1),
                  width: sySetWidth(2)))),
      width: sySetWidth(200),
      height: sySetHeight(220),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: sySetWidth(200),
            height: sySetHeight(100),
            color: AppColors.mainColor,
            child: Text(
              '${labelTitle}',
              style: TextStyle(
                color: AppColors.mainFontColor,
                fontSize: sySetFontSize(28),
              ),
            ),
          ),
          Container(
              alignment: Alignment.center,
              width: sySetWidth(200),
              height: sySetHeight(100),
              color: AppColors.mainFontColor,
              child: Container(
                width: sySetWidth(130),
                height: sySetWidth(80),
                child: FlatButton(
                  color: buttonColor ?? Color.fromRGBO(0, 122, 255, 1),
                  onPressed: () {
                    //  ExtendedNavigator.rootNavigator.pushNewsInfoPageRoute(id:'${this._dataList[index].id}');
                    if (type == 2) {
                      ExtendedNavigator.rootNavigator.pushFeedbackPageRoute(
                          textList: salaryRequestModel.textList,
                          times: salaryRequestModel.ffy,
                          monthText: salaryRequestModel.monthText);
                    } else {
                      ExtendedNavigator.rootNavigator.pushSignPageRoute(
                          salaryRequestModel: salaryRequestModel);
                    }
                  },
                  child: Text(
                    '${buttonText}',
                    style: TextStyle(
                        fontSize: sySetFontSize(28),
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  //获取工资奖金列表
  List<Widget> _getBasePayAllItem(List basepay, int type) {
    List<Widget> baseWidget = [];
    List<String> textList = ['基本工资'];
    for (var i = 0; i < basepay.length; i++) {
      String times = basepay[i].name;
      if (type == 2) {
        times = basepay[i].times;
        textList = basepay[i].textList;
      }

      var t = Container(
        height: sySetHeight(200),
        child: ListView(
          scrollDirection: Axis.horizontal,
          controller: this._controller,
          children: _getBasePayListItemWidget(
              basepay[i].value, basepay[i].name, type,
              ffrq: times, textlist: textList, monthText: basepay[i].monthText),
        ),
      );
      baseWidget.add(t);
    }
    return baseWidget;
  }

  //搜索布局
  _getSearchList() {
    return Container(
//      width: double.infinity,
//      height: sySetHeight(148),
      child: Column(
        children: <Widget>[
          _getSearchTitleWidget(),
          _getSearchWidget(wagesList),
//          _getBasePayAllItem(),
//          _getBasePayAllItem(),
        ],
      ),
    );
  }

  _searchTextFiledWidget(int type, var controller, {String times}) {
    return Container(
      margin: EdgeInsets.only(left: sySetWidth(26)),
      width: sySetWidth(160),
      height: sySetHeight(60),
      decoration: BoxDecoration(
        border: Border.all(
          width: sySetWidth(2),
          color: Color.fromRGBO(229, 229, 229, 1),
        ),
      ),
      child: TextField(
        readOnly: true,
        controller: controller,
        keyboardType: TextInputType.datetime,
        onTap: () {
          _showDatePicker(type);
        },
        maxLines: 1,
        maxLength: 7,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          fontSize: sySetFontSize(28),
          color: Color.fromRGBO(153, 153, 153, 1),
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: "", //最大显示数量的文本
//                enabledBorder: OutlineInputBorder(
//                  borderSide: BorderSide(
//                    color: Color.fromRGBO(232, 232, 232, 1),
//                  ),
//                  borderRadius: BorderRadius.all(
//                    Radius.circular(1),
//                  ),
//                ),
          hintText: times,
//                focusedBorder: OutlineInputBorder(
//                  borderRadius: BorderRadius.all(
//                    Radius.circular(1),
//                  ),
//                  borderSide: BorderSide(
//                    color: Color.fromRGBO(232, 232, 232, 1),
//                  ),
//                ),
        ),
      ),
    );
  }

  //获取下拉选项
  _getSelectItems() {
    if (dorpDown.length != 0) {
      List<DropdownMenuItem> itemList = [];
      var index = 0;
      dorpDown.forEach((element) {
        var t = DropdownMenuItem(
          child: Text(element.label),
          value: element.value,
        );
        itemList.add(t);
      });
      return itemList;
    }
  }

  //搜索布局表头
  _getSearchTitleWidget() {
    return Container(
      color: AppColors.mainFontColor,
      height: sySetHeight(148),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _searchTextFiledWidget(1, dateStart, times: TIME_NOW),
          Container(
            margin: EdgeInsets.fromLTRB(
                sySetWidth(12), sySetHeight(0), sySetWidth(12), 0),
            width: sySetWidth(26),
            height: sySetHeight(2),
            child: Image.asset(
              'images/line.png',
              fit: BoxFit.fill,
            ),
          ),
          _searchTextFiledWidget(2, dateEnd, times: TIME_NOW),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: sySetWidth(12)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: Image.asset(
                        'images/select.png',
                        width: sySetWidth(44),
                        height: sySetWidth(44),
                        fit: BoxFit.fill,
                      ),
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
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.fromLTRB(
                      sySetWidth(5), sySetHeight(0), sySetWidth(20), 0),
                  child: InkWell(
                    child: Image.asset(
                      'images/search.png',
                      fit: BoxFit.fill,
                      width: sySetWidth(44),
                      height: sySetWidth(44),
                    ),
                    onTap: () {
                      _getSearchData();
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //这个返回每一项工资的所有键值对
  //未确认工资明细的每一项布局
  List<Widget> _getSearchListItemWidget(List value) {
    List<Widget> itemWidget = new List();
    for (var i = 0; i < value.length; i++) {
      var t = Container(
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
                    color: Color.fromRGBO(248, 248, 248, 1),
                    width: sySetWidth(2)))),
        width: sySetWidth(200),
        height: sySetHeight(220),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: sySetWidth(200),
              height: sySetHeight(100),
              color: AppColors.mainColor,
              child: Text(
                '${value[i].name}',
                style: TextStyle(
                  color: AppColors.mainFontColor,
                  fontSize: sySetFontSize(28),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: sySetWidth(200),
              height: sySetHeight(100),
              color: AppColors.mainFontColor,
              child: Text(
                '${value[i].value}',
                style: TextStyle(
                  color: Color.fromRGBO(51, 51, 51, 1),
                  fontSize: sySetFontSize(28),
                ),
              ),
            )
          ],
        ),
      );
      itemWidget.add(t);
    }
    return itemWidget;
  }

  //获取工资奖金列表
  List<Widget> _getSearchAllItem(List<List<WagesList>> basepay) {
    print(basepay);
    List<Widget> baseWidget = [];
    for (var i = 0; i < basepay.length; i++) {
      var t = Container(
        height: sySetHeight(200),
        child: ListView(
          scrollDirection: Axis.horizontal,
          controller: this._controller,
          children: _getSearchListItemWidget(basepay[i]),
        ),
      );
      baseWidget.add(t);
    }
    return baseWidget;
  }

  _getSearchWidget(List<List<WagesList>> key) {
    return Container(
      margin: EdgeInsets.only(top: sySetHeight(30)),
      child: Column(
        children: <Widget>[
          Container(
            child: ListView(
              controller: this._controller,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: _getSearchAllItem(key),
            ),
          ),
        ],
      ),
    );
  }
}
