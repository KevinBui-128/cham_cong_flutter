// To parse this JSON data, do
//
//     final employeesModel = employeesModelFromJson(jsonString);

import 'dart:convert';

class EmployeesModel {
  int count;
  List<Employee> employees;
  String error;
  String message;

  EmployeesModel({
    this.count,
    this.employees,
    this.error,
    this.message,
  });

  factory EmployeesModel.fromRawJson(String str) =>
      EmployeesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeesModel.fromJson(Map<String, dynamic> json) => EmployeesModel(
        count: json["count"] == null ? null : json["count"],
        employees: json["employees"] == null
            ? null
            : List<Employee>.from(
                json["employees"].map((x) => Employee.fromJson(x))),
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "employees": employees == null
            ? null
            : List<dynamic>.from(employees.map((x) => x.toJson())),
        "error": error == null ? null : error,
        "message": message == null ? null : message,
      };
}

class Employee {
  String name;
  String password;
  String username;

  Employee({
    this.name,
    this.password,
    this.username,
  });

  factory Employee.fromRawJson(String str) =>
      Employee.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        name: json["name"] == null ? null : json["name"],
        password: json["password"] == null ? null : json["password"],
        username: json["username"] == null ? null : json["username"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "password": password == null ? null : password,
        "username": username == null ? null : username,
      };
}
