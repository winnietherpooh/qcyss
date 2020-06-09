import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import 'package:yss/common/router/router.gr.dart';
import 'package:yss/common/util/screen.dart';
import 'package:yss/model/BannerModel.dart';
import 'package:yss/Config.dart';
import 'package:yss/model/FocusModel.dart';
class BannerPage extends StatefulWidget {
  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  List _dataList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBannerData();
  }


  _getBannerData() async {
    var api = Config.domain+'index.php?m=Home&c=Newapi&a=carousels&cid=${Config.companyId}';
    var result = await Dio().get(api);
    var getData = json.decode(result.data);
    var bannerResult = BannerModel.fromJson(getData);



    setState(() {
      this._dataList = bannerResult.data;
    });
  }


  @override
  Widget build(BuildContext context) {
    if(this._dataList != null){
      return Container(
        height: sySetWidth(330),
        child: new Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.network(
              _dataList[index].img,
              fit: BoxFit.cover,
            );
          },
          autoplay: true,
          itemCount: _dataList.length,
          scrollDirection: Axis.horizontal,
          // pagination: new SwiperPagination(alignment: Alignment.centerRight),
          //control: new SwiperControl(),
          onTap: (v){   //点击事件
            //Navigator.pushNamed(context, '/login');
           ExtendedNavigator.of(context).pushNamed(Routes.loginPageRoute);

          },
        ),
      );
    }else{
      return Text('加载中');
    }
  }
}
