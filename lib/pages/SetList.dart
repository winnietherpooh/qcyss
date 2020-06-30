import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yssqc/common/apis/uploadAvatar.dart';
import 'package:yssqc/common/router/router.gr.dart';
import 'package:yssqc/common/util/screen.dart';
import 'package:yssqc/common/widgets/appbarWidget.dart';
import 'package:yssqc/common/widgets/toast.dart';
import 'package:yssqc/global.dart';
import 'package:yssqc/model/UploadResponseModel.dart';

class SetListPage extends StatefulWidget {
  @override
  _SetListPageState createState() => _SetListPageState();
}

class _SetListPageState extends State<SetListPage> {
  String avatarUrl = Global.profile.userPortrait;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWidget(context, '设置'),
      body: Column(
        children: <Widget>[
          Container(
            height: sySetHeight(110),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(232, 232, 232, 1),
                  width: sySetWidth(2),
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: sySetWidth(24)),
                  child: Text(
                    '头像',
                    style: TextStyle(
                      fontSize: sySetFontSize(30),
                      color: Color.fromRGBO(51, 51, 51, 1),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: sySetWidth(24),
                  ),
                  child: IconButton(
                    icon: ClipOval(
                      child: Image.network(
                        avatarUrl,
                        width: sySetWidth(84),
                        height: sySetWidth(84),
                        fit: BoxFit.cover,
                      ),
                    ),
                    onPressed: () {
//                      ExtendedNavigator.rootNavigator
//                          .pushNamed(Routes.setPassWdPageRoute);
                      _checkNSPhotoLibraryHadPermission();
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            height: sySetHeight(110),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(232, 232, 232, 1),
                  width: sySetWidth(2),
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: sySetWidth(24)),
                  child: Text(
                    '密码',
                    style: TextStyle(
                      fontSize: sySetFontSize(30),
                      color: Color.fromRGBO(51, 51, 51, 1),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 1,
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: OutlineButton(
                          child: Row(
                            children: <Widget>[
                              Text(
                                '设置密码',
                                style: TextStyle(
                                    fontSize: sySetFontSize(28),
                                    color: Color.fromRGBO(153, 153, 153, 1)),
                              ),
                              Image.asset(
                                'images/right.png',
                                width: sySetWidth(24),
                                height: sySetWidth(24),
                              ),
                            ],
                          ),
                          borderSide: BorderSide(
                            style: BorderStyle.none,
                          ),
                          onPressed: () {
                            ExtendedNavigator.rootNavigator
                                .pushNamed(Routes.setPassWdPageRoute);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: sySetHeight(300),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: sySetHeight(96),
                  padding:
                      EdgeInsets.fromLTRB(sySetWidth(32), 0, sySetWidth(32), 0),
                  //因为有他,所以可以设置宽高
                  child: FlatButton(
                    child: Text('退出'),
                    color: Color.fromRGBO(246, 159, 0, 1),
                    onPressed: () {
                      //清空数据
                      Global.delProfile();
                      ExtendedNavigator.rootNavigator
                          .pushNamed(Routes.loginPageRoute);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _checkNSPhotoLibraryHadPermission() {
    if (Platform.isIOS) {
      if (Permission.camera != PermissionStatus.granted) {
        var res = Permission.camera.request();
        if (res.isGranted == PermissionStatus.granted) {
          _selectImgChangeAvatar();
        } else {
          showConfim(
              context, '你设置不允许访问相册,现在无法使用头像上传功能,请点击确定后设置为允许.'
              , gotosetting);
        }
      }
    } else {
      _selectImgChangeAvatar();
    }
  }

  gotosetting() {
    openAppSettings();
  }

  Future _selectImgChangeAvatar() async {
    var images = await ImagePicker().getImage(source: ImageSource.gallery);
    if (images == null) {
      return;
    }
    showLoading(context, '上传头像中');
    UploadResponseModel uploadResponseModel =
        await UploadAvatarApi.uploadImg(context: context, file: images);
    print(uploadResponseModel.error);
    if (uploadResponseModel.error == 200) {
      //更新缓存头像
      Global.profile.userPortrait = uploadResponseModel.data.fileUrl;
      setState(() {
        avatarUrl = uploadResponseModel.data.fileUrl;
      });
      Navigator.pop(context);
      showSuccess(context);
    } else {
      Navigator.pop(context);
      showError(context, text: uploadResponseModel.message);
    }
  }
}
