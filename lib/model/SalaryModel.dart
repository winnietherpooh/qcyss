import 'package:flutter/cupertino.dart';


class SalaryRequestModel {
  String salary;
  String insurance;
  String accumulationFund;
  String childrenNum;
  String childrenEducation;
  String adultEducation;
  String medicalSeriousIllness;
  String houseLoan;
  String houseFund;
  String supportOld;

  SalaryRequestModel({
    @required this.salary,
    @required this.insurance,
    @required this.accumulationFund,
    @required this.childrenNum,
    @required this.childrenEducation,
    @required this.adultEducation,
    @required this.medicalSeriousIllness,
    @required this.houseLoan,
    @required this.houseFund,
    @required this.supportOld
  });

  factory SalaryRequestModel.fromJson(Map<String, dynamic> json) =>
      SalaryRequestModel(
        salary: json["salary"],
        insurance: json["insurance"],
        accumulationFund: json["accumulationFund"],
        childrenNum: json["childrenNum"],
        childrenEducation: json["childrenEducation"],
        adultEducation: json["adultEducation"],
        medicalSeriousIllness: json["medicalSeriousIllness"],
        houseLoan: json["houseLoan"],
        houseFund: json["houseFund"],
        supportOld: json["supportOld"],
      );

  Map<String, dynamic> toJson() => {
    "salary": salary,
    "insurance": insurance,
    "accumulationFund": accumulationFund,
    "childrenEducation": childrenEducation,
    "adultEducation": adultEducation,
    "medicalSeriousIllness": medicalSeriousIllness,
    "houseLoan": houseLoan,
    "houseFund": houseFund,
    "supportOld": supportOld,

  };
}

class SalaryResponseModel {
  SalaryResponseModel({
    this.data,
    this.error,
    this.message,
  });

  Data data;
  int error;
  String message;

  factory SalaryResponseModel.fromJson(Map<String, dynamic> json) => SalaryResponseModel(
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
    this.salary,
    this.insurance,
    this.accumulationFund,
    this.houseLoan,
    this.childrenEducation,
    this.adultEducation,
    this.supportOld,
    this.medicalSeriousIllness,
    this.houseFund,
    this.tax,
    this.taxMoney,
    this.needTaxMoney,
    this.sskcl,
    this.realSalary,
  });

  String salary;
  String insurance;
  String accumulationFund;
  String houseLoan;
  String childrenEducation;
  String adultEducation;
  String supportOld;
  String medicalSeriousIllness;
  String houseFund;
  String tax;
  String taxMoney;
  String needTaxMoney;
  String sskcl;
  String realSalary;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    salary: json["salary"],
    insurance: json["insurance"],
    accumulationFund: json["accumulationFund"],
    houseLoan: json["houseLoan"],
    childrenEducation: json["childrenEducation"],
    adultEducation: json["adultEducation"],
    supportOld: json["supportOld"],
    medicalSeriousIllness: json["MedicalSeriousIllness"],
    houseFund: json["houseFund"],
    tax: json["tax"],
    taxMoney: json["taxMoney"],
    needTaxMoney: json["needTaxMoney"],
    sskcl: json["sskcl"],
    realSalary: json["realSalary"],
  );

  Map<String, dynamic> toJson() => {
    "salary": salary,
    "insurance": insurance,
    "accumulationFund": accumulationFund,
    "houseLoan": houseLoan,
    "childrenEducation": childrenEducation,
    "adultEducation": adultEducation,
    "supportOld": supportOld,
    "MedicalSeriousIllness": medicalSeriousIllness,
    "houseFund": houseFund,
    "tax": tax,
    "taxMoney": taxMoney,
    "needTaxMoney": needTaxMoney,
    "sskcl": sskcl,
    "realSalary": realSalary,
  };
}