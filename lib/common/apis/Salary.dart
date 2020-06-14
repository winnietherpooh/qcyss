import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yss/common/util/utils.dart';
import 'package:yss/global.dart';
import 'package:yss/model/NewsInfoModel.dart';
import 'package:yss/model/NewsModel.dart';
import 'package:yss/model/SalaryModel.dart';

class SalayrCalApi {
  /// banner
  static Future<SalaryResponseModel> getData({
    @required BuildContext context,
    @required SalaryRequestModel salaryRequestModel
  }) async {

    var response = await HttpUtil().post(
      '${Global.domain}/index.php?m=Home&c=Newapi&a=calTax',
      context: context,
        params:salaryRequestModel
    );
    print('=====================');
    print(json.encode(response));
    print('=====================');
    return SalaryResponseModel.fromJson(response);
  }
}


