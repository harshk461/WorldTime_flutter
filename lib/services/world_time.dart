import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class WorldTime {
  String location; //location name for the ui
  String time; //time in that location
  String flag; //urrl to an assets flag icon
  String url; //location url for api endpoint
  WorldTime({this.location, this.time, this.flag, this.url});
  Future<void> getTime() async {
    try {
      //make request
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      //get Properties
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //Create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      print(now);

      //set time property
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('$e');
      time = 'could not get time data';
    }
  }
}
