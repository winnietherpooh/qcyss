import 'package:flutter/material.dart';
import 'package:yssqc/common/util/utils.dart';
import 'package:yssqc/global.dart';
import 'package:yssqc/model/userModel.dart';

/// 用户
class UserAPI {
  /// 登录
  static Future<UserResponseModel> login({
    @required BuildContext context,
    UserLoginRequestEntity params,
  }) async {

    var response = await HttpUtil().post(
      '${Global.domain}index.php?m=Home&c=Newlogin&a=index',
      context: context,
      params: params,
    );
    var t = UserResponseModel.fromJson(response);
    return t;
  }
}
