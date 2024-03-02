import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/Worker/worker.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late String city='Bhilai';
  late String temp;
  late String hum;
  late String air_speed;
  late String des;
  late String main;
  late String icon;

  void startApp(String city) async {
    Worker instance = Worker(location: city);
    await instance.getData();

    air_speed = instance.air_speed;
    temp = instance.temp;
    hum = instance.humidity;
    des = instance.description;
    main = instance.main;
    icon = instance.icon;
    Future.delayed(
      Duration(seconds: 2),
      () {
        Navigator.pushReplacementNamed(context, '/home', arguments: {
          "temp_value": temp,
          "hum_value": hum,
          "main_value": main,
          "air_speed_value": air_speed,
          "des_value": des,
          "icon_value": icon,
          "city_value":city,
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // fetch the data from the API
    Map<dynamic, dynamic>? search =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>?;
    // Map search=ModalRoute.of(context).settings.arguments;
        if(search?.isNotEmpty ?? false){
          city = search!['searchText'];
        } 
    startApp(city);
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150,),
              Image.asset(
                "images/mlogo.png",
                height: 240,
                width: 240,
              ),
              Text(
                "Weather App",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              SizedBox(height: 12),
              Text(
                "Developed by Manish ",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              SizedBox(height: 42),
              SpinKitWave(
                color: Colors.white,
                size: 50,
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue[400],
    );
  }
}




// crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          // children: <Widget>[
          //   FloatingActionButton(
          //     onPressed: () {
          //       Navigator.pushNamed(context, "/home");
          //     },
          //     //  child: Icon(Icons.backspace_sharp,size: 40),
          //     child: Icon(
          //       Icons.add_to_home_screen,
          //       size: 30,
          //     ),
          //     backgroundColor: Colors.blue[100],
          //     shape: RoundedRectangleBorder(
          //       borderRadius:
          //           BorderRadius.circular(100.0), // Adjust the radius as needed
          //     ),
          //   ),
          //   SizedBox(height: 20),