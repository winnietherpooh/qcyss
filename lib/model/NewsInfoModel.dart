class NewsInfoModel {
  Data data;
  String error;
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