import 'dart:convert';

import 'package:chamcongapp/configs/config.dart';
import 'package:chamcongapp/data/model/calendarModel.dart';
import 'package:http/http.dart';

Future<dynamic> getCalendar() async {
  try {
    Response response = await get(
        ConfigsApp.isDebugMode
            ? ConfigsApp.baseUrl + ConfigsApp.calendarUrl
            : ConfigsApp.baseUrl + ConfigsApp.calendarUrl,
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['message'] == 'success') {
        return CalendarModel.fromJson(data);
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