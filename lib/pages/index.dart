import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yssqc/common/util/update.dart';
import 'package:yssqc/global.dart';
import 'package:yssqc/pages/login.dart';
import '../tabs/Taps.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
    if (true) {
      doAppUpdate();
    }
  }

  Future doAppUpdate() async {
    await Future.delayed(Duration(seconds: 3), () async {
      if (Global.isIOS == false &&
          await Permission.storage.isGranted == false) {
        await [Permission.storage].request();
      }
      if (await Permission.storage.isGranted) {
        AppUpdateUtil().run(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 750,
      height:1334-40,
      allowFontScaling: true,
    );
    return Global.isOfflineLogin == true
        ? Taps() :  LoginPage();
  }
}
