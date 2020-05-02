import 'dart:convert';

import 'package:chamcongapp/configs/config.dart';
import 'package:chamcongapp/data/model/checkinModel.dart';
import 'package:http/http.dart';

Future<dynamic> getCheckin() async {
  try {
    Map<String, dynamic> body = {
      "username": ConfigsApp.userName,
      "workTime": 12,
      "checkinDate": 8,
      "checkinTime": 12,
      "checkoutTime": 8
    };
    var finalBody = json.encode(body);
    Response response = await post(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.checkinUrl
            : ConfigsApp.baseUrl + ConfigsApp.checkinUrl,
        body: finalBody,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'success') {
        return CheckinModel.fromJson(data);
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