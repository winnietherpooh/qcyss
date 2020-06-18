import 'dart:async';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yssqc/common/util/screen.dart';
import 'package:yssqc/common/router/router.gr.dart';

Future<bool> toastInfo({
  @required String msg,
  Color backgroundColor = Colors.black,
  Color textColor = Colors.white,
}) async {
  return await Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    //timeInSecForIos: 1,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: sySetFontSize(16),
  );
}

void showConfim(context, String notice, Function confirmCallback) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return Center(
        child: Card(
          child: Container(
            width: 250,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            constraints: BoxConstraints(minHeight: 120, minWidth: 180),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: Text(
                    '请先确认工资',
                    style: TextStyle(
                      color: Color.fromRGBO(51, 51, 51, 1),
                      fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        child: Container(
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              '取消',
                              style: TextStyle(
                                color: Color.fromRGBO(249, 158, 5, 1),
                                fontSize: Theme.of(context).textTheme.bodyText2.fontSize,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        child: Container(
                          height: 20,
                          child: VerticalDivider(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Align(
                        child: Container(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              confirmCallback();
                            },
                            child: Text(
                              '确认',
                              style: TextStyle(
                                  color: Color.fromRGBO(51, 51, 51, 1),
                                  fontSize: Theme.of(context).textTheme.bodyText2.fontSize),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showLoading(context, String text) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  //阴影
                  BoxShadow(
                    color: Colors.black12,
                    //offset: Offset(2.0,2.0),
                    blurRadius: 10.0,
                  )
                ]),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: 120, minWidth: 180),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

void showError(context, {String text = "网络错误", int times = 2000}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  //阴影
                  BoxShadow(
                    color: Colors.black12,
                    //offset: Offset(2.0,2.0),
                    blurRadius: 10.0,
                  )
                ]),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: 120, minWidth: 180),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Icon(Icons.error),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
              ],
            ),
          ),
        );
      });
  var timer;
  timer = Timer.periodic(Duration(milliseconds: times), (t) {
    Navigator.pop(context);
    t.cancel(); //取消定时器 timer.cancle();
  });
}

void showSuccess(context,
    {String text = "操作成功", int times = 1500}) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  //阴影
                  BoxShadow(
                    color: Colors.black12,
                    //offset: Offset(2.0,2.0),
                    blurRadius: 10.0,
                  )
                ]),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: 120, minWidth: 180),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.done,
                    size: sySetFontSize(28),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ],
            ),
          ),
        );
      });
  var timer;
  timer = Timer.periodic(Duration(milliseconds: times), (t) {
    Navigator.pop(context);
    t.cancel(); //取消定时器 timer.cancle();
  });
}

void showSuccessRoute (context,Function  gotoRoute,
    {String text = "操作成功", int times = 2500}) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  //阴影
                  BoxShadow(
                    color: Colors.black12,
                    //offset: Offset(2.0,2.0),
                    blurRadius: 10.0,
                  )
                ]),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: 120, minWidth: 180),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: sySetWidth(100),
                  width: sySetWidth(100),
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.orange,
                    size: sySetFontSize(100),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
              ],
            ),
          ),
        );
      });
       Timer.periodic(Duration(milliseconds: times), (t) {
         t.cancel();
         gotoRoute();
       });
}


getLoadingWidget(){
  return Container(
    margin: EdgeInsets.only(top: sySetWidth(30)),
    alignment: Alignment.center,
    child: SizedBox(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(
        strokeWidth: 3,
      ),
    ),
  );
}



void showNotice(context, String notice) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Center(
        child: Card(
          child: Container(
            width: 250,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            constraints: BoxConstraints(minHeight: 80, minWidth: 180),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(sySetWidth(10)),
                  alignment: Alignment.center,
                  child: Text(
                    notice,
                    style: TextStyle(
                      color: Color.fromRGBO(51, 51, 51, 1),
                      fontSize: sySetFontSize(26),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  height: sySetHeight(50),
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      '知道了',
                      style: TextStyle(
                        color: Color.fromRGBO(249, 158, 5, 1),
                        fontSize: Theme.of(context).textTheme.bodyText2.fontSize,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}