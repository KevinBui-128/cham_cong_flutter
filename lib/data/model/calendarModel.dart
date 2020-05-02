import 'dart:convert';

class CalendarModel {
    int count;
    List<Datum> data;
    String error;
    String message;

    CalendarModel({
        this.count,
        this.data,
        this.error,
        this.message,
    });

    factory CalendarModel.fromRawJson(String str) => CalendarModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CalendarModel.fromJson(Map<String, dynamic> json) => CalendarModel(
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
    int dayOff;
    int specialDay;
    int workDay;

    Datum({
        this.dayOff,
        this.specialDay,
        this.workDay,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        dayOff: json["dayOff"] == null ? null : json["dayOff"],
        specialDay: json["specialDay"] == null ? null : json["specialDay"],
        workDay: json["workDay"] == null ? null : json["workDay"],
    );

    Map<String, dynamic> toJson() => {
        "dayOff": dayOff == null ? null : dayOff,
        "specialDay": specialDay == null ? null : specialDay,
        "workDay": workDay == null ? null : workDay,
    };
}
