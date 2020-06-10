import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yss/Config.dart';
import 'package:yss/common/util/utils.dart';
import 'package:yss/global.dart';
import 'package:yss/model/BannerModel.dart';

/// banner
class BannerAPI {
  /// banner
  static Future<BannerModel> getBanner({
    @required BuildContext context,
  }) async {
    var response = await HttpUtil().get(
      '${Global.domain}index.php?m=Home&c=Newapi&a=carousels&cid=${Config.companyId}',
      context: context,
    );
   return BannerModel.fromJson(json.decode(response));
  }
}
