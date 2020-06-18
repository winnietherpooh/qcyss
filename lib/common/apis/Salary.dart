import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yssqc/common/util/utils.dart';
import 'package:yssqc/global.dart';
import 'package:yssqc/model/NewsInfoModel.dart';
import 'package:yssqc/model/NewsModel.dart';
import 'package:yssqc/model/SalaryModel.dart';

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
    return SalaryResponseModel.fromJson(response);
  }
}


