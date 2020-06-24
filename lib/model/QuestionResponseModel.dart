
class QuestionSubmitRequestModel {
  QuestionSubmitRequestModel({
    this.data,
  });

  String data;
  factory QuestionSubmitRequestModel.fromJson(Map<String, dynamic> json) => QuestionSubmitRequestModel(
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
  };
}



class QuestionRequestModel {
  QuestionRequestModel({
    this.titleId,
    this.content,
  });

  int titleId;
  String content;

  factory QuestionRequestModel.fromJson(Map<String, dynamic> json) => QuestionRequestModel(
    titleId: json["titleId"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "titleId": titleId,
    "content": content,
  };
}


class QuestionResponseModel {
  QuestionResponseModel({
    this.data,
    this.error,
    this.message,
  });

  List<QuestionItem> data;
  int error;
  String message;

  factory QuestionResponseModel.fromJson(Map<String, dynamic> json) => QuestionResponseModel(
    data: List<QuestionItem>.from(json["data"].map((x) => QuestionItem.fromJson(x))),
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
    "message": message,
  };
}

class QuestionItem {
  QuestionItem({
    this.id,
    this.title,
    this.sign,
    this.sort,
    this.type,
    this.answerList,
  });

  int id;
  String title;
  int sign;
  int sort;
  int type;
  List<AnswerList> answerList;

  factory QuestionItem.fromJson(Map<String, dynamic> json) => QuestionItem(
    id: json["id"],
    title: json["title"],
    sign: json["sign"],
    sort: json["sort"],
    type: json["type"],
    answerList: List<AnswerList>.from(json["answerList"].map((x) => AnswerList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "sign": sign,
    "sort": sort,
    "type": type,
    "answerList": List<dynamic>.from(answerList.map((x) => x.toJson())),
  };
}

class AnswerList {
  AnswerList({
    this.id,
    this.content,
  });

  String id;
  String content;

  factory AnswerList.fromJson(Map<String, dynamic> json) => AnswerList(
    id: json["id"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
  };
}
