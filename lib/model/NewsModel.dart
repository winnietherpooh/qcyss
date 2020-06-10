class NewsModel {
  int page;
  int mpage;
  List<NewsItemModel> data;
  int error;
  String message;

  NewsModel({this.page, this.mpage, this.data, this.error, this.message});

  NewsModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    mpage = json['mpage'];
    if (json['data'] != null) {
      data = new List<NewsItemModel>();
      json['data'].forEach((v) {
        data.add(new NewsItemModel.fromJson(v));
      });
    }
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['mpage'] = this.mpage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['message'] = this.message;
    return data;
  }
}

class NewsItemModel {
  String id;
  String title;
  String img;
  String content;
  String addTime;

  NewsItemModel({this.id, this.title, this.img, this.content, this.addTime});

  NewsItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    img = json['img'];
    content = json['content'];
    addTime = json['add_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['img'] = this.img;
    data['content'] = this.content;
    data['add_time'] = this.addTime;
    return data;
  }
}