import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class WorldTime {
  String location; //location name for the ui
  String time; //time in that location
  String flag; //urrl to an assets flag icon
  String url; //location url for api endpoint
  bool isdaytime; //true or falseif daytime or not
  WorldTime({this.location, this.time, this.flag, this.url, this.isdaytime});
  Future<void> getTime() async {
    try {
      //make request
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      //get Properties
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);

      //Create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      // print(now);

      //set time property

      isdaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'could not get time data';
    }
  }
}
