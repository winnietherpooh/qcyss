import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yssqc/common/util/utils.dart';
import 'package:yssqc/global.dart';
import 'package:yssqc/model/Feedback.dart';
import 'package:yssqc/model/SearchModel.dart';
import 'package:yssqc/model/responseModel.dart';

class SearchSalaryApi {
  /// banner
  static Future<SearchModel> getData({
    @required BuildContext context,
    @required SearchRequestModel searchRequestModel
  }) async {

    var response = await HttpUtil().post(
      '${Global.domain}index.php?m=Home&c=Newapi&a=checksalary',
      context: context,
      params: searchRequestModel
    );
    return SearchModel.fromJson(response);
  }
}





