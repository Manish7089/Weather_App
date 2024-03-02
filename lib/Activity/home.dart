import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  @override
  void dispose() {
    super.dispose();
    print("widget destroyed");
  }

  @override
  void initState() {
    super.initState();
    print("This is a init state");
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    print("Set state called");
  }

  @override
  Widget build(BuildContext context) {
    var city_name = [
      'Mumbai',
      'Bhilai',
      'Raipur',
      'london',
      'Durg',
      'Raigarh',
      'Delhi',
      'Ambikapur'
    ];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];

    Map<dynamic, dynamic>? info =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>?;
    // Map info = ModalRoute.of(context).settings.arguments;
    String temp = (((info!['temp_value']).toString()));
    String air = (((info['air_speed_value']).toString()));
    if (temp == "NA") {
      print("NA");
    } else {
      temp = (((info!['temp_value']).toString()).substring(0, 5));
      air = (((info['air_speed_value']).toString()).substring(0, 4));
    }
    String hum = (info['hum_value']);
    String icon = (info['icon_value']);
    String getcity = (info['city_value']);
    String des = info['des_value'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          title: Text(
            "Weather App",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.cyan[300],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                  Colors.blueAccent,
                  Colors.greenAccent,
                  Color.fromARGB(255, 231, 219, 113),
                ])),
            child: Column(
              children: [
                Container(
                  //search wala
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if ((searchController.text).replaceAll(" ", "") ==
                              "") {
                            print("blank Search");
                          } else {
                            Navigator.pushReplacementNamed(context, "/loading",
                                arguments: {
                                  "searchText": searchController.text,
                                });
                          }
                        },
                        child: Container(
                          child: Icon(Icons.search, color: Colors.cyan),
                        ),
                      ),
                      Expanded(
                          child: TextField(
                        onEditingComplete: () {
                          if ((searchController.text).replaceAll(" ", "") ==
                              "") {
                            print("blank Search");
                          } else {
                            Navigator.pushReplacementNamed(context, "/loading",
                                arguments: {
                                  "searchText": searchController.text,
                                });
                          }
                        },
                        controller: searchController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search $city",
                            hintStyle: TextStyle(color: Colors.black38)),
                      )),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Image.network(
                                  "https://openweathermap.org/img/wn/$icon@2x.png",
                                  height: 60),
                              SizedBox(width: 25),
                              Column(
                                children: [
                                  Text(
                                    "$des",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "In $getcity",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        padding: EdgeInsets.all(25),
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(WeatherIcons.thermometer, size: 50),
                                Text(
                                  "  Temperature",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$temp",
                                  style: TextStyle(fontSize: 74),
                                ),
                                Text(" °C", style: TextStyle(fontSize: 30)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          height: 160,
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.humidity),
                                  Text(
                                    " Humidity",
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                              Text("$hum",
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                "Percent",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          )),
                    ),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          height: 160,
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    WeatherIcons.day_windy,
                                    size: 15,
                                  ),
                                  Text(
                                    "  Wind-Speed",
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                              Text("$air",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                "km/hr",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      // Text("Made By Manish"),
                      Text("Data provided By OpenWeatherMap")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(2.0),
        color: Colors.grey[300], // Background color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Developed by: M@nish  ',
              style: TextStyle(
                fontSize: 8.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
