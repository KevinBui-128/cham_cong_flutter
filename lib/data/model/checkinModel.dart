// To parse this JSON data, do
//
//     final checkinModel = checkinModelFromJson(jsonString);

import 'dart:convert';

class CheckinModel {
    int count;
    List<Datum> data;
    String error;
    String message;

    CheckinModel({
        this.count,
        this.data,
        this.error,
        this.message,
    });

    factory CheckinModel.fromRawJson(String str) => CheckinModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CheckinModel.fromJson(Map<String, dynamic> json) => CheckinModel(
        count: json["count"] == null ? null : json["count"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null ? null : error,
        "message": message == null ? null : message,
    };
}

class Datum {
    int checkinDate;
    int checkinTime;
    int checkoutTime;
    String username;
    int workTime;

    Datum({
        this.checkinDate,
        this.checkinTime,
        this.checkoutTime,
        this.username,
        this.workTime,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        checkinDate: json["checkinDate"] == null ? null : json["checkinDate"],
        checkinTime: json["checkinTime"] == null ? null : json["checkinTime"],
        checkoutTime: json["checkoutTime"] == null ? null : json["checkoutTime"],
        username: json["username"] == null ? null : json["username"],
        workTime: json["workTime"] == null ? null : json["workTime"],
    );

    Map<String, dynamic> toJson() => {
        "checkinDate": checkinDate == null ? null : checkinDate,
        "checkinTime": checkinTime == null ? null : checkinTime,
        "checkoutTime": checkoutTime == null ? null : checkoutTime,
        "username": username == null ? null : username,
        "workTime": workTime == null ? null : workTime,
    };
}
