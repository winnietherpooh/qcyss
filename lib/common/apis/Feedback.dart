import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yssqc/common/util/utils.dart';
import 'package:yssqc/global.dart';
import 'package:yssqc/model/Feedback.dart';
import 'package:yssqc/model/FeedbackInfoModel.dart';
import 'package:yssqc/model/responseModel.dart';

class FeedbackApi {
  /// banner
  static Future<ResponseModel> postData({
    @required BuildContext context,
    @required FeedbackRequestEntity feedbackRequestEntity
  }) async {

    var response = await HttpUtil().post(
      '${Global.domain}index.php?m=Home&c=Newapi&a=addFeedback',
      context: context,
      params: feedbackRequestEntity
    );
    return ResponseModel.fromJson(response);
  }

  static Future<FeedbackResponseModel> getData({
    @required BuildContext context,
    @required int p
  }) async {

    var response = await HttpUtil().get(
        '${Global.domain}index.php?m=Home&c=Newapi&a=myFeedbackList&p=${p}',
        context: context,
    );

    return FeedbackResponseModel.fromJson(json.decode(response));
  }


  static Future<FeedbackInfoModel> getInfo({
    @required BuildContext context,
    @required String id
  }) async {
    Map<String,dynamic> map = {
      'id':id,
    };
    var response = await HttpUtil().postForm(
      '${Global.domain}index.php?m=Home&c=Newapi&a=myFeedbackInfo',
      context: context,
      params: map
    );
    return FeedbackInfoModel.fromJson(json.decode(response));
  }
}





