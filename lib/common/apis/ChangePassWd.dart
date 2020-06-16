import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yss/common/util/utils.dart';
import 'package:yss/global.dart';
import 'package:yss/model/UploadResponseModel.dart';
import 'package:yss/model/responseModel.dart';

class ChangePassWdApi{
  static Future<ResponseModel> postData({
    @required BuildContext context,
    @required String oldPwd,
    @required String newPassWd
  }) async {


    Map<String,dynamic> map = {
      'oldPsd':oldPwd,
      'newPsd':newPassWd
    };
    var response = await HttpUtil().postForm(
      '${Global.domain}index.php?m=Home&c=Newapi&a=editPassword',
      context: context,
      params:map,
    );
    return ResponseModel.fromJson(json.decode(response));
  }
}




