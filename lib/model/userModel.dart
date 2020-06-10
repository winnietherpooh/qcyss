// 登录请求
import 'package:flutter/foundation.dart';

class UserLoginRequestEntity {
  String userAccount;
  String passWord;
  
  UserLoginRequestEntity({
    @required this.userAccount,
    @required this.passWord,
  });

  factory UserLoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginRequestEntity(
        userAccount: json["userAccount"],
        passWord: json["passWord"],
      );

  Map<String, dynamic> toJson() => {
        "userAccount": userAccount,
        "passWord": passWord,
      };
}
class UserResponseModel {
    UserResponseModel({
        this.data,
        this.error,
        this.message,
    });

    UserInfoModel data;
    int error;
    String message;

    factory UserResponseModel.fromJson(Map<String, dynamic> json) => UserResponseModel(
        data: UserInfoModel.fromJson(json["data"]),
        error: json["error"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "error": error,
        "message": message,
    };
}

class UserInfoModel {
    UserInfoModel({
        this.userId,
        this.userPortrait,
        this.userPosition,
        this.account,
        this.userName,
        this.cName,
        this.dName,
        this.token,
    });

    String userId;
    String userPortrait;
    String userPosition;
    String account;
    String userName;
    String cName;
    String dName;
    String token;

    factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        userId: json["user_id"],
        userPortrait: json["user_portrait"],
        userPosition: json["user_position"],
        account: json["account"],
        userName: json["user_name"],
        cName: json["c_name"],
        dName: json["d_name"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_portrait": userPortrait,
        "user_position": userPosition,
        "account": account,
        "user_name": userName,
        "c_name": cName,
        "d_name": dName,
        "token": token,
    };
}