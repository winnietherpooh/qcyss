import 'package:flutter/material.dart';
import 'package:yss/common/util/screen.dart';

getAppBarWidget(String title,{bool isShowIcon=true}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
    ),
    centerTitle: true,
      iconTheme:IconThemeData(
        color: Color.fromRGBO(255, 255, 255, 1)
      ),
    elevation: 0,
      automaticallyImplyLeading:isShowIcon
  );
}
