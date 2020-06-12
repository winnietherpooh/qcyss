import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yss/common/util/utils.dart';
import 'package:yss/global.dart';
import 'package:yss/model/SignSalaryResponseModel.dart';

class SignSalaryApi {
  /// banner
  static Future<SignSalaryResponseModel> getData({
    @required BuildContext context,
  }) async {

    var response = await HttpUtil().get(
      '${Global.domain}index.php?m=Home&c=Newapi&a=showNeedSignList',
      context: context,
    );
    return SignSalaryResponseModel.fromJson(json.decode(response));
  }
}




