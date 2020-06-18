import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yssqc/common/util/utils.dart';
import 'package:yssqc/global.dart';
import 'package:yssqc/model/SalaryModel.dart';
import 'package:yssqc/model/SignSalaryRequestModel.dart';
import 'package:yssqc/model/SignSalaryResponseModel.dart';
import 'package:yssqc/model/responseModel.dart';

class SignSalaryApi {
  /// banner
  static Future<SignSalaryResponseModel> getData({
    @required BuildContext context,

  }) async {

    var response = await HttpUtil().get(
      '${Global.domain}index.php?m=Home&c=Newapi&a=showNeedSignList',
      context: context,
    );
    return SignSalaryResponseModel.fromJson(json.decode(response));
  }
}


class SignImageUploadApi{
  static Future<ResponseModel> getData({
    @required BuildContext context,
    @required SignSalaryRequestModel salaryRequestModel,
    @required File file
  }) async {

    String path = file.path;
    var fileData = await MultipartFile.fromFile(
        path
    );
    Map<String,dynamic> map = {
      'ffrq':salaryRequestModel.ffrq,
      'ffy':salaryRequestModel.ffy,
      'welfarename':salaryRequestModel.welfarename,
      'signIMg':fileData
    };
    var response = await HttpUtil().postForm(
      '${Global.domain}index.php?m=Home&c=Newapi&a=qeurengongzi',
      context: context,
      params:map,
    );
//    if(!(response is ResponseModel)){
//      return ResponseModel(error: 404,message: '网络错误');
//    }
    return ResponseModel.fromJson(json.decode(response));
  }
}




