import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:yssqc/model/userModel.dart';

import 'common/util/utils.dart';
import 'common/values/values.dart';


/// 全局配置
class Global {
  /// 用户配置
  static UserInfoModel profile = UserInfoModel(
    token: null,
  );

  static String domain = 'http://test.yousuanshi.com/reckoner/';
  //  static String domain = 'http://192.168.0.136/';

  static String publicDomain = 'http://update.yousuanshi.com/';
  //企业ID
  static int companyId = 18;
  /// 服务器连接超时时间
  static int connectTimeout = 2000;

  static Color bgColor = Color.fromRGBO(255, 255, 255, 1);
  //响应流间隔时间
  static int  receiveTimeout = 5000;
  /// 发布渠道
  static String channel = "xiaomi";

  static String Version = '0.0.1';
  /// 是否 ios
  static bool isIOS = Platform.isIOS;

  // /// android 设备信息
  // static AndroidDeviceInfo androidDeviceInfo;

  // /// ios 设备信息
  // static IosDeviceInfo iosDeviceInfo;

  /// 包信息
  static PackageInfo packageInfo;

  /// 是否第一次打开
  static bool isFirstOpen = false;

  /// 是否离线登录
  static bool isOfflineLogin = false;

  // /// 应用状态,
  // static AppState appState = AppState();

  /// 是否 release
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  /// init
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();

    // 读取设备信息
    // DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    // if (Global.isIOS) {
    //   Global.iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    // } else {
    //   Global.androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    // }

    // 包信息
   Global.packageInfo = await PackageInfo.fromPlatform();

    // 工具初始
    await StorageUtil.init();
    HttpUtil();

    // 读取设备第一次打开
    isFirstOpen = !StorageUtil().getBool(STORAGE_DEVICE_ALREADY_OPEN_KEY);
    if (isFirstOpen) {
      StorageUtil().setBool(STORAGE_DEVICE_ALREADY_OPEN_KEY, true);
    }

    // 读取离线用户信息
    var _profileJSON = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);
    if (_profileJSON != null) {
      profile = UserInfoModel.fromJson(_profileJSON);
      isOfflineLogin = true;
    }

    // android 状态栏为透明的沉浸
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  // 持久化 用户信息
  static Future<bool> saveProfile(UserInfoModel userResponse) {
    profile = userResponse;

    return StorageUtil()
        .setJSON(STORAGE_USER_PROFILE_KEY, userResponse.toJson());
  }

  static Future<bool> delProfile() {
    return StorageUtil()
        .remove(STORAGE_USER_PROFILE_KEY);
  }
}
