import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:smokeless_weather/models/tomorrow_io_weather_model.dart';
import 'package:smokeless_weather/utils/get_weather_img_name.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  late Future<TomorrowIoWeather> futureWeather;
  Future<TomorrowIoWeather> fetchWeatherData() async {
    String url =
        "https://api.tomorrow.io/v4/weather/forecast?location=nanyuki&apikey=929vL1pLyInK3ZRp8Hc9oA8OzeGQmIFi";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> rawWeatherData =
          jsonDecode(response.body) as Map<String, dynamic>;

      final weatherData = TomorrowIoWeather.fromJson(rawWeatherData);
      log(weatherData.toString());
      return weatherData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeatherData();
  }

  String displayTime(int hour) {
    if (hour == 0 || hour == 24) {
      return "12 AM";
    } else if (hour == 12) {
      return "12 PM";
    } else if (hour < 12) {
      return "$hour AM";
    } else {
      int pmTime = hour - 12;
      return "$pmTime PM";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final weatherData = snapshot.data!;
            return Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.black87,
              appBar: AppBar(
                title: const Text(
                  'Nanyuki',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue.shade200,
                            Colors.blue,
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              MediaQuery.of(context).size.width / 8),
                          bottomRight: Radius.circular(
                              MediaQuery.of(context).size.width / 8),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).viewPadding.top + 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                // height: 250,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        "Mostly Sunny",
                                        style: TextStyle(color: Colors.white54),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0, 10),
                                      child: Text(
                                        "24\u00B0",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 85,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0, 0.5),
                                      child: SvgPicture.asset(
                                        "assets/svg/weather_icons/partly-cloudy-day.svg",
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svg/weather_icons/wind-beaufort-0.svg",
                                          width: 50,
                                        ),
                                        Text(
                                          "9km/h",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "Wind",
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 100,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svg/weather_icons/humidity.svg",
                                          width: 50,
                                        ),
                                        Text(
                                          "25%",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "Humidity",
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 100,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Icons.visibility,
                                          size: 42,
                                          color: Colors.white54,
                                        ),
                                        Text(
                                          "1.7km",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "Visibility",
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 21, 10, 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Today",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 21),
                              ),
                              TextButton(
                                onPressed: () {
                                  log("Clicked next 7 days");
                                },
                                child: Row(
                                  children: [
                                    Text("Next 7 Days"),
                                    Icon(Icons.chevron_right),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 170,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ...weatherData.timelines.hourly.map(
                                  (e) => TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.all(8)),
                                    onPressed: () {
                                      log("Pressed hour column at time ${e.time.hour}");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(17),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            displayTime(e.time.hour),
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 16),
                                          ),
                                          SvgPicture.asset(
                                            "assets/svg/weather_icons/${getWeatherImgName(e.minutelyHourlyValues.weatherCode)}.png",
                                            width: 80,
                                          ),
                                          Text(
                                            "${e.minutelyHourlyValues.temperature}\u00B0",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
