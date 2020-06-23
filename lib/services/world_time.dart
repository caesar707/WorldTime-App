import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {

  String url;
  String location;
  String flag;
  String time;
  bool isDayTime;

  WorldTime({this.flag, this.url, this.location});

  Future<void> getTime() async {

    try {
      Response response = await get(
          "http://worldtimeapi.org/api/timezone/$url");
      Map map = jsonDecode(response.body);

      String dateTime = map['datetime'];
      String offset = map['utc_offset'].substring(1, 3);

      DateTime timeNow = DateTime.parse(dateTime);
      timeNow = timeNow.add(Duration(hours: int.parse(offset)));

      isDayTime = timeNow.hour > 6 && timeNow.hour < 20 ? true : false;
      time = DateFormat.jm().format(timeNow);

    } catch(e) {
      print(e);
      time = 'could not get the time';
    }
  }

}