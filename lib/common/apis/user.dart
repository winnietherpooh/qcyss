import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yss/common/util/utils.dart';
import 'package:yss/global.dart';
import 'package:yss/model/userModel.dart';

/// 用户
class UserAPI {
  /// 登录
  static Future<UserInfoModel> login({
    @required BuildContext context,
    UserLoginRequestEntity params,
  }) async {

    var response = await HttpUtil().post(
      '${Global.domain}index.php?m=Home&c=Newlogin&a=index',
      context: context,
      params: params,
    );
    var t = UserResponseModel.fromJson(response);
    return t.data;
  }
}
