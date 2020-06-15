class SignSalaryRequestModel {
  SignSalaryRequestModel({
    this.ffrq,
    this.ffy,
    this.signIMg,
    this.welfarename,
    this.textList,
    this.monthText
  });

  String ffrq;
  String monthText;
  String ffy;
  String signIMg;
  int welfarename;
  List<String> textList;

  factory SignSalaryRequestModel.fromJson(Map<String, dynamic> json) => SignSalaryRequestModel(
    ffrq: json["ffrq"],
    ffy: json["ffy"],
    monthText: json["monthText"],
    signIMg: json["signIMg"],
    welfarename: json["welfarename"],
    textList: List<String>.from(json["textList"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "welfarename": welfarename,
    "monthText": monthText,
    "signIMg": signIMg,
    "ffy": ffy,
    "ffrq": ffrq,
    "textList": List<dynamic>.from(textList.map((x) => x)),
  };
}







