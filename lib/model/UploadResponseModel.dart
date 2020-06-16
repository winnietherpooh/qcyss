class UploadResponseModel {
  UploadResponseModel({
    this.data,
    this.error,
    this.message,
  });

  Data data;
  int error;
  String message;

  factory UploadResponseModel.fromJson(Map<String, dynamic> json) => UploadResponseModel(
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
    this.fileUrl,
  });

  String fileUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fileUrl: json["file_url"],
  );

  Map<String, dynamic> toJson() => {
    "file_url": fileUrl,
  };
}