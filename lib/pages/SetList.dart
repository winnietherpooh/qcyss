import 'package:flutter/material.dart';
import 'package:yss/common/util/screen.dart';

class SetList extends StatefulWidget {
  @override
  _SetListState createState() => _SetListState();
}

class _SetListState extends State<SetList> {
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
                      Navigator.pushNamed(context, '/setlist');
                    },
                  ),
                )
              ],
            ),

          ),Container(
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
                        margin: EdgeInsets.only(right: sySetWidth(6)),
                        child: OutlineButton(
                          child: Text('设置密码'),
                          borderSide:BorderSide(
                            style: BorderStyle.none,
                          ),
                          onPressed: () {
                              
                          },
                        ),

                      ),
                      Container(
                        margin: EdgeInsets.only(right: sySetWidth(24)),
                        child: Image.asset('images/right.png',width: sySetWidth(24),height: sySetWidth(24),),
                      )
                    ],
                  )
                )
              ],
            ),

          )
        ],
      ),
    );
  }
}
