import 'dart:convert';

import 'package:chamcongapp/configs/config.dart';
import 'package:http/http.dart';

Future<int> postCheckin(
    {int checkinDate, int checkinTime}) async {
  try {
    Map<String, dynamic> body = {
      "username": ConfigsApp.userName,
      "workTime": 0,
      "checkinDate": checkinDate,
      "checkinTime": checkinTime,
      "checkoutTime": 0
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.checkinUrl + ConfigsApp.addUrl
            : ConfigsApp.baseUrl + ConfigsApp.checkinUrl + ConfigsApp.addUrl,
        body: finalBody,
        headers: {
          "Content-Type": "application/json",
        });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == "Add success") {
        return 1;
      } else {
        return 0;
      }
    } else {
      print("lỗi đăng ký do api");
      return 0;
    }
  } catch (e) {
    print(e.toString());
    return 0;
  }
}
