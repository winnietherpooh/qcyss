import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yss/common/apis/ChangePassWd.dart';
import 'package:yss/common/router/router.gr.dart';
import 'package:yss/common/util/screen.dart';
import 'package:yss/common/widgets/toast.dart';
import 'package:yss/global.dart';
import 'package:yss/model/responseModel.dart';

class SetPassWdPage extends StatefulWidget {
  @override
  _SetPassWdPageState createState() => _SetPassWdPageState();
}

class _SetPassWdPageState extends State<SetPassWdPage> {
  var _oldPassWd = new TextEditingController();
  var _newPassWd = new TextEditingController();
  var _repeatPassWd = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('密码设置'),
          centerTitle: true,
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
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
                            '原密码',
                            style: TextStyle(
                              fontSize: sySetFontSize(30),
                              color: Color.fromRGBO(51, 51, 51, 1),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: sySetWidth(25)),
                            child: TextField(
                              controller: _oldPassWd,
                              maxLines: 1,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  hintText: '请输入原密码',
                                  hintStyle: TextStyle(
                                      fontSize: sySetFontSize(28),
                                      color: Color.fromRGBO(153, 153, 153, 1)
                                  ),
                                  labelStyle: TextStyle(
                                      fontSize: sySetFontSize(28),
                                      color: Color.fromRGBO(51, 51, 51, 1)
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
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
                            '新密码',
                            style: TextStyle(
                              fontSize: sySetFontSize(30),
                              color: Color.fromRGBO(51, 51, 51, 1),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: sySetWidth(25)),
                            child: TextField(
                              controller: _newPassWd,
                              decoration: InputDecoration(
                                  hintText: '请输入新密码（6-18位字母加数字组成）',
                                  labelStyle: TextStyle(
                                    fontSize: sySetFontSize(30),
                                  ),
                                  hintStyle: TextStyle(
                                      fontSize: sySetFontSize(28),
                                      color: Color.fromRGBO(153, 153, 153, 1)
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
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
                            '确认密码',
                            style: TextStyle(
                              fontSize: sySetFontSize(30),
                              color: Color.fromRGBO(51, 51, 51, 1),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: sySetWidth(25)),
                            child: TextField(
                              controller: _repeatPassWd,
                              decoration: InputDecoration(
                                  hintText: '请再次输入密码（6-18位字母加数字组成）',
                                  labelStyle: TextStyle(
                                    fontSize: sySetFontSize(30),
                                  ),
                                  hintStyle: TextStyle(
                                      fontSize: sySetFontSize(28),
                                      color: Color.fromRGBO(153, 153, 153, 1)
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sySetHeight(300),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: sySetHeight(96),
                          padding: EdgeInsets.fromLTRB(
                              sySetWidth(32), 0, sySetWidth(32), 0),
                          //因为有他,所以可以设置宽高
                          child: FlatButton(
                            child: Text('确认', style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: sySetFontSize(32),
                                fontWeight: FontWeight.bold
                            ),),
                            color: Color.fromRGBO(246, 159, 0, 1),
                            onPressed: () {
                              _changeMyPassWd();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  _changeMyPassWd() async{
    if (_oldPassWd.value.text.length == null) {
      showError(context, text: '请输入旧密码', times: 1000);
      return;
    }
    if (_newPassWd.value.text.length == 0) {
      showError(context, text: '请输入新密码', times: 1000);
      return;
    }
    if (_repeatPassWd.value.text.length == 0) {
      showError(context, text: '请再次输入新密码', times: 1000);
      return;
    }
    if (_repeatPassWd.value.text != _newPassWd.value.text) {
      showError(context, text: '两次输入的密码不一致', times: 1000);
      return;
    }
    if (_oldPassWd.value.text == _repeatPassWd.value.text) {
      showError(context, text: '新密码和旧密码不能相同', times: 1000);
      return;
    }
    showLoading(context, "正在提交");
    ResponseModel responseModel = await ChangePassWdApi.postData(context: context,
        oldPwd: _oldPassWd.value.text,
        newPassWd: _newPassWd.value.text);
    if(responseModel.error == 200){
      //去登录
      Global.delProfile();
      Navigator.pop(context);
      showSuccessRoute(context,_gotoLogin);
    }else{
      Navigator.pop(context);
      showError(context,text:responseModel.message);
    }
  }

  _gotoLogin(){
    ExtendedNavigator.rootNavigator.pushNamed(Routes.loginPageRoute);
  }
}
