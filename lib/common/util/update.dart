import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yss/common/apis/apis.dart';
import 'package:yss/common/widgets/toast.dart';
import 'package:yss/global.dart';
import 'package:yss/model/appUpdate.dart';

/// app 升级
class AppUpdateUtil {
  static AppUpdateUtil _instance = AppUpdateUtil._internal();
  factory AppUpdateUtil() => _instance;

  BuildContext _context;
  UpdateAppModel _appUpdateInfo;
  AppInfoModel _appInfoModel;
  AppUpdateUtil._internal();

  /// 获取更新信息
  Future run(BuildContext context) async {
    _context = context;

    // 提交 设备类型、发行渠道、架构、机型
    AppUpdateRequestEntity requestDeviceInfo = AppUpdateRequestEntity(
      clientType: Global.isIOS == true ? "2" : "1",
      version: Global.Version
    );
    _appUpdateInfo =
        await AppApi.update(context: context, appUpdateRequestEntity: requestDeviceInfo);
    print(_appUpdateInfo.toJson());
    print('返回值的结果${_appUpdateInfo.error}');
    if(_appUpdateInfo.error == 200){
      _appInfoModel = _appUpdateInfo.data;
      _runAppUpdate();
    }
  }

  /// 检查是否有新版
  Future _runAppUpdate() async {
    // 比较版本
    // 安装
      print('进入检测方法');
      _appUpdateConformDialog(() {
        Navigator.of(_context).pop();
        if (Global.isIOS == true) {
          // 去苹果店
          InstallPlugin.gotoAppStore(_appInfoModel.downurl);
        } else {
          // apk 下载安装
          toastInfo(msg: "开始下载升级包");
          _downloadAPKAndSetup(_appInfoModel.downurl);
        }
      });

  }

  /// 下载文件 & 安装
  Future _downloadAPKAndSetup(String fileUrl) async {
    // 下载
    Directory externalDir = await getExternalStorageDirectory();
    String fullPath = externalDir.path + "/release.apk";

    Dio dio = Dio(BaseOptions(
        responseType: ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        }));
    Response response = await dio.get(
      fileUrl,
    );

    File file = File(fullPath);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();

    // 安装
    await InstallPlugin.installApk(fullPath, Global.packageInfo.packageName);
  }

  /// 升级确认对话框
  void _appUpdateConformDialog(VoidCallback onPressed) {
    EasyDialog(
        title: Text(
          "发现新版本${_appInfoModel.versionStr}",
          style: TextStyle(fontWeight: FontWeight.bold),
          textScaleFactor: 1.2,
        ),
        description: Text(
          _appInfoModel.versionStr,
          textScaleFactor: 1.1,
          textAlign: TextAlign.center,
        ),
        height: 220,
        contentList: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new FlatButton(
                padding: const EdgeInsets.only(top: 8.0),
                textColor: Colors.lightBlue,
                onPressed: onPressed,
                child: new Text(
                  "同意",
                  textScaleFactor: 1.2,
                ),
              ),
              new FlatButton(
                padding: const EdgeInsets.only(top: 8.0),
                textColor: Colors.lightBlue,
                onPressed: () {
                  Navigator.of(_context).pop();
                },
                child: new Text(
                  "取消",
                  textScaleFactor: 1.2,
                ),
              ),
            ],
          )
        ]).show(_context);
  }
}
