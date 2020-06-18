import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yssqc/common/util/utils.dart';
import 'package:yssqc/global.dart';
import 'package:yssqc/model/BannerModel.dart';

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
