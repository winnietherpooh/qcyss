// 登录请求
import 'package:flutter/foundation.dart';

class FeedbackRequestEntity {
  int cid;
  String wagesText;
  String content;
  String times;

  FeedbackRequestEntity({
    @required this.cid,
    @required this.wagesText,
    @required this.content,
    @required this.times,
  });

  factory FeedbackRequestEntity.fromJson(Map<String, dynamic> json) =>
      FeedbackRequestEntity(
        cid: json["cid"],
        wagesText: json["wagesText"],
        content: json["content"],
        times: json["times"],
      );

  Map<String, dynamic> toJson() => {
    "cid": cid,
    "wagesText": wagesText,
    "content": content,
    "times": times,
  };
}

class FeedbackResponseModel {
  FeedbackResponseModel({
    this.page,
    this.mpage,
    this.data,
    this.error,
    this.message,
  });

  int page;
  int mpage;
  List<Datum> data;
  int error;
  String message;

  factory FeedbackResponseModel.fromJson(Map<String, dynamic> json) => FeedbackResponseModel(
    page: json["page"],
    mpage: json["mpage"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "mpage": mpage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
    "message": message,
  };
}

class Datum {
  Datum({
    this.id,
    this.content,
    this.addTime,
    this.sign,
    this.backIsable,
  });

  String id;
  String content;
  String addTime;
  String sign;
  String backIsable;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    content: json["content"],
    addTime: json["add_time"],
    sign: json["sign"],
    backIsable: json["back_isable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "add_time": addTime,
    "sign": sign,
    "back_isable": backIsable,
  };
}
