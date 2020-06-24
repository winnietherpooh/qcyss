/*
 * @Author: your name
 * @Date: 2020-06-10 21:22:18
 * @LastEditTime: 2020-06-11 22:00:19
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \yssqc\lib\pages\banner.dart
 */ 
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:yssqc/common/apis/apis.dart';
import 'package:yssqc/common/router/router.gr.dart';
import 'package:yssqc/common/util/screen.dart';
import 'package:yssqc/model/BannerModel.dart';
class BannerPage extends StatefulWidget {
  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  List<bannerItemModel>_dataList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBannerData();
  }

  _getBannerData() async{
    BannerModel bannerItem = await BannerAPI.getBanner(
      context: context,
    );
    setState(() {
      this._dataList = bannerItem.data;
    });
  }




  @override
  Widget build(BuildContext context) {
    if(this._dataList != null){
      return Container(
        height: sySetWidth(330),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: Image.network(
                _dataList[index].img,
                fit: BoxFit.cover,
              ),
              onTap: (){
                switch(_dataList[index].sign){
                  case "1":
                    ExtendedNavigator.rootNavigator
                        .pushNewsInfoPageRoute(id: '${_dataList[index].ids}');
                    break;
                  case "2":
                    break;
                  case "3":
                    ExtendedNavigator.rootNavigator
                        .pushNamed(Routes.questionPageRoute);
                    break;
                }
              },
            );
          },
          autoplay: true,
          itemCount: _dataList.length,
          scrollDirection: Axis.horizontal,
          // pagination: new SwiperPagination(alignment: Alignment.centerRight),
          //control: new SwiperControl(),
//          onIndexChanged: (index){
//            print( _dataList[index].img);
//          },
//          onTap: (v){   //点击事件
//           ExtendedNavigator.of(context).pushNamed(Routes.loginPageRoute);
//
//          },
        ),
      );
    }else{
      return Container(
        height: sySetWidth(330),
        child: new Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.asset(
              'images/banner.png',
              fit: BoxFit.cover,
            );
          },
          autoplay: true,
          itemCount: 1,
          scrollDirection: Axis.horizontal,
          // pagination: new SwiperPagination(alignment: Alignment.centerRight),
          //control: new SwiperControl(),
          onTap: (v){   //点击事件
           ExtendedNavigator.of(context).pushNamed(Routes.loginPageRoute);

          },
        ),
      );
    }
  }
}
