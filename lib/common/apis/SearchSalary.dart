import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yss/common/util/utils.dart';
import 'package:yss/global.dart';
import 'package:yss/model/Feedback.dart';
import 'package:yss/model/SearchModel.dart';
import 'package:yss/model/responseModel.dart';

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





