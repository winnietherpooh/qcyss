import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yssqc/common/util/utils.dart';
import 'package:yssqc/global.dart';
import 'package:yssqc/model/UploadResponseModel.dart';

class UploadAvatarApi{
  static Future<UploadResponseModel> uploadImg({
    @required BuildContext context,
    @required PickedFile file
  }) async {

    String path = file.path;
    var fileData = await MultipartFile.fromFile(
        path
    );
    Map<String,dynamic> map = {
      'imgFile':fileData
    };
    var response = await HttpUtil().postForm(
      '${Global.domain}index.php?m=Home&c=Newapi&a=upload_img',
      context: context,
      params:map,
    );
    return UploadResponseModel.fromJson(json.decode(response));
  }
}




