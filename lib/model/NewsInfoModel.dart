import 'package:flutter/cupertino.dart';

class NewsInfoRequestModel {
  String id;
  String type;

  NewsInfoRequestModel({
    @required this.id,
    @required this.type,
  });

  factory NewsInfoRequestModel.fromJson(Map<String, dynamic> json) =>
      NewsInfoRequestModel(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
  };
}

class NewsInfoModel {
  Data data;
  int error;
  String message;

  NewsInfoModel({this.data, this.error, this.message});

  NewsInfoModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['error'] = this.error;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String time;
  String title;
  String content;

  Data({this.time, this.title, this.content});

  Data.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}