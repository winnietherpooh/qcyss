class ResponseModel {
  ResponseModel({
    this.data,
    this.error,
    this.message,
  });

  List data;
  int error;
  String message;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    data: json["data"],
    error: json["error"],
    message: json["message"],
  );


}