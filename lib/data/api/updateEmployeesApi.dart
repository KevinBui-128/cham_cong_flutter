import 'dart:convert';

import 'package:chamcongapp/configs/config.dart';
import 'package:http/http.dart';

Future<int> postUpdateEmployees(
    {String name, String username, String password}) async {
  try {
    Map<String, dynamic> body = {
      "name": name,
      "username": username,
      "password": password
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl +
                ConfigsApp.employeesUrl +
                ConfigsApp.updateUrl
            : ConfigsApp.baseUrl +
                ConfigsApp.employeesUrl +
                ConfigsApp.updateUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message' == "update success"]) {
        return 1;
      } else if (data['message'] == "Wrong username" ||
          data['message'] == "update fail") {
        return 2;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  } catch (e) {
    print(e.toString());
    return 0;
  }
}
