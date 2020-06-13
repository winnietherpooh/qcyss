class SignSalaryRequestModel {
  SignSalaryRequestModel({
    this.ffrq,
    this.ffy,
    this.signIMg,
    this.welfarename,
  });

  String ffrq;
  String ffy;
  String signIMg;
  int welfarename;


  factory SignSalaryRequestModel.fromJson(Map<String, dynamic> json) => SignSalaryRequestModel(
    ffrq: json["ffrq"],
    ffy: json["ffy"],
    signIMg: json["signIMg"],
    welfarename: json["welfarename"],
  );

  Map<String, dynamic> toJson() => {
    "welfarename": welfarename,
    "signIMg": signIMg,
    "ffy": ffy,
    "ffrq": ffrq,
  };
}







