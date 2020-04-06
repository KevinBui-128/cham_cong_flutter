import 'dart:convert';

import 'package:chamcongapp/configs/config.dart';
import 'package:chamcongapp/data/model/employeesModel.dart';
import 'package:http/http.dart';

Future<EmployeesModel> getEmployees() async {
  try {
    Response response = await get(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.employeesUrl
            : ConfigsApp.baseUrl + ConfigsApp.employeesUrl,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'success') {
        return EmployeesModel.fromJson(data);
      } else {
        return null;
      }
    } else {
      print("Lỗi api");
      return null;
    }
  } catch (e) {
    print(e.toString());
    return null;
  }
}
