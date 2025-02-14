import 'package:flutter/material.dart';
import 'package:yssqc/common/util/http.dart';
import 'package:yssqc/global.dart';
import 'package:yssqc/model/appUpdate.dart';

/// 系统相关
class AppApi {
  /// 获取最新版本信息
  static Future<UpdateAppModel> update({
    @required BuildContext context,
    @required AppUpdateRequestEntity appUpdateRequestEntity
  }) async {
    var response = await HttpUtil().post(
      '${Global.publicDomain}isneedupdate',
      context: context,
      params: appUpdateRequestEntity,
    );
    return UpdateAppModel.fromJson(response);
  }
}
