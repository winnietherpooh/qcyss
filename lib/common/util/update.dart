import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yssqc/common/apis/apis.dart';
import 'package:yssqc/common/util/screen.dart';
import 'package:yssqc/common/widgets/toast.dart';
import 'package:yssqc/global.dart';
import 'package:yssqc/model/appUpdate.dart';

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
    showDialog(
      barrierDismissible: false,
      context: _context,
      builder: (context) {
        return Center(
          child: Card(
            child: Container(
              width: 250,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              constraints: BoxConstraints(minHeight: 80, minWidth: 180),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(sySetWidth(10)),
                    alignment: Alignment.center,
                    child: Text(
                      '发现新版本${_appInfoModel.versionStr},现在可下载更新',
                      style: TextStyle(
                        color: Color.fromRGBO(51, 51, 51, 1),
                        fontSize: sySetFontSize(30),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Container(
                    height: sySetHeight(50),
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: onPressed,
                      child: Text(
                        '确定',
                        style: TextStyle(
                          color: Color.fromRGBO(249, 158, 5, 1),
                          fontSize: Theme.of(context).textTheme.bodyText2.fontSize,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
