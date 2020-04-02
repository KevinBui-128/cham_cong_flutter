// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

class RegisterModel {
    String error;
    String message;

    RegisterModel({
        this.error,
        this.message,
    });

    factory RegisterModel.fromRawJson(String str) => RegisterModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
    };
}
