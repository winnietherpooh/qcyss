import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yssqc/common/util/utils.dart';
import 'package:yssqc/global.dart';
import 'package:yssqc/model/BannerModel.dart';
import 'package:yssqc/model/QuestionResponseModel.dart';
import 'package:yssqc/model/responseModel.dart';

/// banner
class QuestionApi {
  /// banner
  static Future<QuestionResponseModel> getData({
    @required BuildContext context,
  }) async {
    var response = await HttpUtil().get(
      '${Global.domain}index.php?m=Home&c=Newapi&a=getQuestion',
      context: context,
    );
   return QuestionResponseModel.fromJson(json.decode(response));
  }

  static Future<ResponseModel> postData({
    @required BuildContext context,
    @required QuestionSubmitRequestModel questionSubmitRequestModel
  }) async {
    var response = await HttpUtil().post(
      '${Global.domain}index.php?m=Home&c=Newapi&a=addAnswer',
      context: context,
      params: questionSubmitRequestModel
    );
    print('========API刚获取玩数据打印开始=========');
    print(response);
    print('========API刚获取玩数据打印结束=========');
    return ResponseModel.fromJson(response);
  }
}
