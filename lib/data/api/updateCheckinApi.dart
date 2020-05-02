import 'dart:convert';

import 'package:chamcongapp/configs/config.dart';
import 'package:http/http.dart';

Future<int> postUpdateCheckin(
    {int workTime, int checkoutTime}) async {
  try {
    Map<String, dynamic> body = {
      "username": ConfigsApp.userName,
      "workTime": workTime,
      "checkinDate": ConfigsApp.checkin,
      "checkinTime": ConfigsApp.checkin,
      "checkoutTime": checkoutTime
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl +
                ConfigsApp.checkinUrl +
                ConfigsApp.updateUrl
            : ConfigsApp.baseUrl +
                ConfigsApp.checkinUrl +
                ConfigsApp.updateUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == "update success") {
        return 1;
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