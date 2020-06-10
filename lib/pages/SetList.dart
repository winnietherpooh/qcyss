import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yss/common/router/router.gr.dart';
import 'package:yss/common/util/screen.dart';
import 'package:yss/global.dart';

class SetListPage extends StatefulWidget {
  @override
  _SetListPageState createState() => _SetListPageState();
}

class _SetListPageState extends State<SetListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
        centerTitle: true,
      ),
      body: Column(
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
                    '头像',
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
                  margin: EdgeInsets.only(
                    right: sySetWidth(24),
                  ),
                  child: IconButton(
                    icon: ClipOval(
                      child: Image.network(
                        'http://cdn.toolvip.com//imagedemo/2.jpg',
                        width: sySetWidth(84),
                        height: sySetWidth(84),
                        fit: BoxFit.cover,
                      ),
                    ),
                    onPressed: () {
                      ExtendedNavigator.rootNavigator.pushNamed(Routes.setPassWdPageRoute);
                    },
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
                    '密码',
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
                            Text('设置密码'),
                            Image.asset(
                              'images/right.png',
                              width: sySetWidth(24),
                              height: sySetWidth(24),
                            ),
                          ],
                        ),
                        borderSide: BorderSide(
                          style: BorderStyle.none,
                        ),
                        onPressed: () {
                          ExtendedNavigator.rootNavigator.pushNamed(Routes.setPassWdPageRoute);
                        },
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
          SizedBox(height: sySetHeight(300),),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: sySetHeight(96),
                  padding: EdgeInsets.fromLTRB(sySetWidth(32), 0, sySetWidth(32), 0),
                  //因为有他,所以可以设置宽高
                  child: FlatButton(
                    child: Text('退出'),
                    color: Color.fromRGBO(246, 159, 0, 1),
                    onPressed: () {
                      //清空数据
                      Global.delProfile();
                      ExtendedNavigator.rootNavigator.pushNamed(Routes.loginPageRoute);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
