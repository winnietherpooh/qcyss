import 'dart:convert';

import 'package:flutter/material.dart';
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
      '${Global.domain}index.php?m=Home&c=Newapi&a=carousels&cid=${Global.companyId}',
      context: context,
    );
   return BannerModel.fromJson(json.decode(response));
  }
}
