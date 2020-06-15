class SearchRequestModel {
  SearchRequestModel({
    this.cid,
    this.startTime,
    this.endTime,
    this.type
  });

  int cid;
  String startTime;
  String endTime;
  String type;

  factory SearchRequestModel.fromJson(Map<String, dynamic> json) => SearchRequestModel(
    cid: json["cid"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "cid": cid,
    "startTime": startTime,
    "endTime": endTime,
    "type": type,
  };
}

class SearchModel {
  SearchModel({
    this.data,
    this.error,
    this.message,
  });

  ResponseData data;
  int error;
  String message;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    data: ResponseData.fromJson(json["data"]),
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "error": error,
    "message": message,
  };
}

class ResponseData {
  ResponseData({
    this.wagesDropdown,
    this.wagesList,
  });

  List<WagesDropdown> wagesDropdown;
  List<List<WagesList>> wagesList;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    wagesDropdown: List<WagesDropdown>.from(json["wagesDropdown"].map((x) => WagesDropdown.fromJson(x))),
    wagesList: List<List<WagesList>>.from(json["wagesList"].map((x) => List<WagesList>.from(x.map((x) => WagesList.fromJson(x))))),
  );

  Map<String, dynamic> toJson() => {
    "wagesDropdown": List<dynamic>.from(wagesDropdown.map((x) => x.toJson())),
    "wagesList": List<dynamic>.from(wagesList.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
  };
}

class WagesDropdown {
  WagesDropdown({
    this.label,
    this.value,
  });

  String label;
  String value;

  factory WagesDropdown.fromJson(Map<String, dynamic> json) => WagesDropdown(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}

class WagesList {
  WagesList({
    this.name,
    this.value,
  });

  String name;
  dynamic value;

  factory WagesList.fromJson(Map<String, dynamic> json) => WagesList(
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
  };
}
