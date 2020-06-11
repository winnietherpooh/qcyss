import 'package:flutter/material.dart';
import 'package:yss/common/apis/Salary.dart';
import 'package:yss/common/util/screen.dart';
import 'package:yss/model/SalaryModel.dart';

class SalaryInfoPage extends StatefulWidget {
  final SalaryRequestModel salaryRequestModel;
  SalaryInfoPage(this.salaryRequestModel);
  @override
  _SalaryInfoPageState createState() => _SalaryInfoPageState();
}

class _SalaryInfoPageState extends State<SalaryInfoPage> {
  Data _salaryData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getdata();
  }

  _getdata() async {
    SalaryResponseModel salaryResponseModel = await SalayrCalApi.getData(
        context: context, salaryRequestModel: this.widget.salaryRequestModel);
    setState(() {
      this._salaryData = salaryResponseModel.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('计算结果'),
        centerTitle: true,
      ),
      body: _getAllData(),
    );
  }

  _getAllData() {
    if (this._salaryData == null) {
      return Container(
        child: ListView(
          children: <Widget>[
            _getItem('税前工资', '0'),
            _getItem('应缴所得税额', '0'),
            _getItem('适用税率', '0'),
            _getItem('应缴税款', '0'),
            _getItem('速算扣除率', '0'),
            _getItem('税后工资', '0'),
            _getItem('各项社会保险', '0'),
            _getItem('公积金', '0'),
            _getItem('住房贷款利息', '0'),
            _getItem('子女教育', '0'),
            _getItem('继续教育', '0'),
            _getItem('大病医疗', '0'),
            _getItem('赡养老人','0'),
          ],
        ),
      );
    } else {

        return Container(
      child: ListView(
        children: <Widget>[
          _getItem('税前工资', this._salaryData.salary ?? ""),
          _getItem('应缴所得税额', this._salaryData.needTaxMoney ?? ""),
          _getItem('适用税率', this._salaryData.tax ?? ""),
          _getItem('应缴税款', this._salaryData.needTaxMoney ?? ""),
          _getItem('速算扣除率', this._salaryData.sskcl ?? ""),
          _getItem('税后工资', this._salaryData.realSalary ?? ""),
          _getItem('各项社会保险', this._salaryData.insurance ?? ""),
          _getItem('公积金', this._salaryData.accumulationFund ?? ""),
          _getItem('住房贷款利息', this._salaryData.houseLoan ?? ""),
          _getItem('子女教育', this._salaryData.childrenEducation ?? ""),
          _getItem('继续教育', this._salaryData.adultEducation ?? ""),
          _getItem('大病医疗', this._salaryData.medicalSeriousIllness ?? ""),
          _getItem('赡养老人', this._salaryData.supportOld ?? ""),
        ],
      ),
    );
    }
  }

  _getItem(String key, String value) {
    return Container(
      height: sySetHeight(110),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(232, 232, 232, 1),
            width: sySetWidth(2),
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: sySetWidth(24)),
            child: Text(
              '${key}',
              style: TextStyle(
                fontSize: sySetFontSize(30),
                color: Color.fromRGBO(51, 51, 51, 1),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 1,
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  child: OutlineButton(
                    child: Row(
                      children: <Widget>[
                        Text('${value}'),
                      ],
                    ),
                    borderSide: BorderSide(
                      style: BorderStyle.none,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
