import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yss/common/router/router.gr.dart';
import 'package:yss/common/util/screen.dart';

class SetPassWdPage extends StatefulWidget {
  @override
  _SetPassWdPageState createState() => _SetPassWdPageState();
}

class _SetPassWdPageState extends State<SetPassWdPage> {
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
                              decoration: InputDecoration(
                                  hintText: '请输入原密码',
                                  labelStyle: TextStyle(
                                    fontSize: sySetFontSize(30),
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
                              decoration: InputDecoration(
                                  hintText: '请输入新密码（6-18位字母加数字组成）',
                                  labelStyle: TextStyle(
                                    fontSize: sySetFontSize(30),
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
                              decoration: InputDecoration(
                                  hintText: '请再次输入密码（6-18位字母加数字组成）',
                                  labelStyle: TextStyle(
                                    fontSize: sySetFontSize(30),
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
                            child: Text('确认',style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: sySetFontSize(32),
                              fontWeight: FontWeight.bold
                            ),),
                            color: Color.fromRGBO(246, 159, 0, 1),
                            onPressed: () {
                              ExtendedNavigator.rootNavigator.pushNamed(Routes.loginPageRoute);
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
}
