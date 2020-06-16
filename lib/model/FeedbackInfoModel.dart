class FeedbackInfoModel {
  FeedbackInfoModel({
    this.data,
    this.error,
    this.message,
  });

  Data data;
  int error;
  String message;

  factory FeedbackInfoModel.fromJson(Map<String, dynamic> json) => FeedbackInfoModel(
    data: Data.fromJson(json["data"]),
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "error": error,
    "message": message,
  };
}

class Data {
  Data({
    this.id,
    this.content,
    this.addTime,
    this.sign,
    this.type,
    this.backCont,
  });

  String id;
  String content;
  String addTime;
  String sign;
  String type;
  String backCont;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    content: json["content"],
    addTime: json["add_time"],
    sign: json["sign"],
    type: json["type"],
    backCont: json["back_cont"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "add_time": addTime,
    "sign": sign,
    "type": type,
    "back_cont": backCont,
  };
}
