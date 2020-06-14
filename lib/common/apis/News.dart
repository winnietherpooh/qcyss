import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yss/common/util/utils.dart';
import 'package:yss/global.dart';
import 'package:yss/model/NewsInfoModel.dart';
import 'package:yss/model/NewsModel.dart';

/// 用户
class NewsListApi {
  /// banner
  static Future<NewsModel> getData({
    @required BuildContext context,
    int page
  }) async {

    var response = await HttpUtil().get(
      '${Global.domain}index.php?m=Home&c=Newapi&'
          'a=newList&cid=${Global.companyId}',
      context: context,
     // params: newsRequestModel
    );
   // print(response);
    return NewsModel.fromJson(json.decode(response));
  }
}


class NewsInfoApi {
  /// banner
  static Future<NewsInfoModel> getData({
    @required BuildContext context,
    @required NewsInfoRequestModel newsInfoRequestModel
  }) async {

    var response = await HttpUtil().post(
      '${Global.domain}index.php?m=Home&c=Newapi&a=details',
      context: context,
        params:newsInfoRequestModel
    );
    return NewsInfoModel.fromJson((response));
  }
}


