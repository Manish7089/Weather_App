import 'dart:convert';
import 'package:http/http.dart' as http;

class Worker {
  String location;
  //construtor
  Worker({required this.location}) {
    location = location;
  }

  String temp = '';
  String humidity = '';
  String air_speed = '';
  String description = '';
  String main = '';
  String icon = '';

  Future<void> getData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=4da315246df54dc2464309ea5d6e1637'));
      Map data = jsonDecode(response.body);
      // print(data);

      // Getting temperature,humidity,air_speed
      Map temp_data = data['main'];
      double getTemp = temp_data['temp'] - 273.15;
      String getHumidity = temp_data['humidity'].toString();

      //getting air_speed
      Map wind_data = data['wind'];
      double getAir_speed = wind_data['speed'] / 0.27777777777778;

      // Getting description, main
      List wea_data = data['weather'];
      Map des_weather = wea_data[0];
      String getDesc = des_weather['description'];
      String getMain_desc = des_weather['main'];
      String getIcon=des_weather['icon'];

      //Assigning values
      temp = getTemp.toString(); //Celcius
      humidity = getHumidity; //%
      air_speed = getAir_speed.toString(); //km-per-hr
      description = getDesc;
      main = getMain_desc;
      icon=getIcon.toString();
    } catch (e) {
      temp = "NA";
      humidity = "NA";
      air_speed = "NA ";
      description = "Can't get data";
      main = "NA";
      icon = "09d";
    }
    /* List wea_data = data['weather'];
    Map typeWeather = wea_data[0];
    print(wea_data);
    print(typeWeather['main']);*/
    // // print(temp_data);
    // print(temp);
  }
}
