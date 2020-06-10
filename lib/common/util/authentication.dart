import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yss/common/router/router.gr.dart';
import 'package:yss/common/util/utils.dart';
import 'package:yss/common/values/values.dart';
import 'package:yss/global.dart';

/// 检查是否有 token
Future<bool> isAuthenticated() async {
  var profileJSON = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);
  return profileJSON != null ? true : false;
}

/// 删除缓存 token
Future deleteAuthentication() async {
  await StorageUtil().remove(STORAGE_USER_PROFILE_KEY);
  Global.profile = null;
}

/// 重新登录
Future goLoginPage(BuildContext context) async {
  await deleteAuthentication();
  ExtendedNavigator.rootNavigator.pushNamedAndRemoveUntil(
      Routes.loginPageRoute, (Route<dynamic> route) => false);
}
