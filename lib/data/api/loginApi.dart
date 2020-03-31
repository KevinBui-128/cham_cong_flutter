import 'dart:convert';

import 'package:chamcongapp/configs/config.dart';
import 'package:http/http.dart';

Future<int> postLogin({String name, String username, String password}) async {
  try {
    Map<String, dynamic> body = {
      "name": name,
      "username": username,
      "password": password
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode ? ConfigsApp.baseUrl : ConfigsApp.baseUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == "add success") {
        return 1;
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
