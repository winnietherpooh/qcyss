class AppUpdateRequestEntity {
  String clientType;
  String version;


  AppUpdateRequestEntity({
    this.clientType,
    this.version,
  });

  factory AppUpdateRequestEntity.fromJson(Map<String, dynamic> json) =>
      AppUpdateRequestEntity(
        clientType: json["clientType"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
    "clientType": clientType,
    "version": version,
  };
}






class UpdateAppModel {
  UpdateAppModel({
    this.data,
    this.error,
    this.message,
  });

  AppInfoModel data;
  int error;
  String message;

  factory UpdateAppModel.fromJson(Map<String, dynamic> json) => UpdateAppModel(
    data: AppInfoModel.fromJson(json["data"]),
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "error": error,
    "message": message,
  };
}

class AppInfoModel {
  AppInfoModel({
    this.downurl,
    this.versionStr,
  });

  String downurl;
  String versionStr;

  factory AppInfoModel.fromJson(Map<String, dynamic> json) => AppInfoModel(
    downurl: json["downurl"],
    versionStr: json["versionStr"],
  );

  Map<String, dynamic> toJson() => {
    "downurl": downurl,
    "versionStr": versionStr,
  };
}