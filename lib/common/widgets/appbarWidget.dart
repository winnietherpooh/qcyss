
import 'package:flutter/material.dart';
getAppBarWidget(BuildContext context,String title,{bool isShowIcon=true,Function reflush}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
    ),
//      leading: Offstage(
//        offstage: isShowIcon ? false : true,
//        child: IconButton(
//          icon: Icon(Icons.arrow_back),
//          onPressed: (){
//            if(reflush == null){
//              Navigator.pop(context);
//            }else{
//              reflush();
//            }
//          },
//        ),
//      ),//设置导航的图标
    centerTitle: true,
      iconTheme:IconThemeData(
        color: Color.fromRGBO(255, 255, 255, 1)
      ),
    elevation: 0,
    automaticallyImplyLeading:isShowIcon
  );
}
