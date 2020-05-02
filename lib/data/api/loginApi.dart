import 'dart:convert';

import 'package:chamcongapp/configs/config.dart';
import 'package:http/http.dart';

Future<int> postLogin({String username, String password}) async {
  try {
    Map<String, dynamic> body = {
      "name": "null",
      "username": username,
      "password": password,
      "phone": 123,
      "address": "null"
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.loginUrl
            : ConfigsApp.baseUrl + ConfigsApp.loginUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == "Login Success") {
        return 1;
      } else if (data['message'] == "Wrong username") {
        return 2;
      } else if (data['message'] == "Wrong password") {
        return 3;
      } else {
        return 0;
      }
    } else {
      print("lỗi đăng nhập do api");
      return 0;
    }
  } catch (e) {
    print(e.toString());
    return 0;
  }
}
