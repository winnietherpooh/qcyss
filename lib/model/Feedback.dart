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