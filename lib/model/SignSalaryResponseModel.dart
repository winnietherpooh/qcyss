class SignSalaryResponseModel {
  SignSalaryResponseModel({
    this.data,
    this.error,
    this.message,
  });

  Data data;
  int error;
  String message;

  factory SignSalaryResponseModel.fromJson(Map<String, dynamic> json) => SignSalaryResponseModel(
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
    this.welfarepay,
    this.basepay,
  });

  List<Welfarepay> welfarepay;
  List<Basepay> basepay;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    welfarepay: List<Welfarepay>.from(json["welfarepay"].map((x) => Welfarepay.fromJson(x))),
    basepay: List<Basepay>.from(json["basepay"].map((x) => Basepay.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "welfarepay": List<dynamic>.from(welfarepay.map((x) => x.toJson())),
    "basepay": List<dynamic>.from(basepay.map((x) => x.toJson())),
  };
}

class Basepay {
  Basepay({
    this.name,
    this.value,
    this.monthText
  });

  String name;
  String monthText;
  List<Value> value;

  factory Basepay.fromJson(Map<String, dynamic> json) => Basepay(
    name: json["name"],
    monthText: json["monthText"],
    value: List<Value>.from(json["value"].map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "monthText": monthText,
    "value": List<dynamic>.from(value.map((x) => x.toJson())),
  };
}

class Value {
  Value({
    this.name,
    this.value,
  });

  String name;
  String value;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
  };
}

class Welfarepay {
  Welfarepay({
    this.name,
    this.times,
    this.textList,
    this.value,
    this.monthText,
  });

  String name;
  String times;
  List<String> textList;
  String monthText;
  List<Value> value;

  factory Welfarepay.fromJson(Map<String, dynamic> json) => Welfarepay(
    name: json["name"],
    times: json["times"],
    monthText: json["monthText"],
    textList: List<String>.from(json["textList"].map((x) => x)),
    value: List<Value>.from(json["value"].map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "times": times,
    "monthText": monthText,
    "textList": List<dynamic>.from(textList.map((x) => x)),
    "value": List<dynamic>.from(value.map((x) => x.toJson())),
  };
}