class BannerModel {
  List<bannerItemModel> data;
  String error;
  String message;

  BannerModel({this.data, this.error, this.message});

  BannerModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<bannerItemModel>();
      json['data'].forEach((v) {

        data.add(new bannerItemModel.fromJson(v));
      });
    }
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['message'] = this.message;
    return data;
  }
}

class bannerItemModel {
  String id;
  String ids;
  String title;
  String img;
  String sort;
  String sign;
  String addTime;
  String addUser;
  String cid;

  bannerItemModel(
      {this.id,
        this.ids,
        this.title,
        this.img,
        this.sort,
        this.sign,
        this.addTime,
        this.addUser,
        this.cid});

  bannerItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ids = json['ids'];
    title = json['title'];
    img = json['img'];
    sort = json['sort'];
    sign = json['sign'];
    addTime = json['add_time'];
    addUser = json['add_user'];
    cid = json['cid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ids'] = this.ids;
    data['title'] = this.title;
    data['img'] = this.img;
    data['sort'] = this.sort;
    data['sign'] = this.sign;
    data['add_time'] = this.addTime;
    data['add_user'] = this.addUser;
    data['cid'] = this.cid;
    return data;
  }
}