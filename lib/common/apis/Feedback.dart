import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yss/common/util/utils.dart';
import 'package:yss/global.dart';
import 'package:yss/model/Feedback.dart';
import 'package:yss/model/responseModel.dart';

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
}





