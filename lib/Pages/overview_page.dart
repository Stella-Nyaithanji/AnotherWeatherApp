import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:smokeless_weather/models/tomorrow_io_weather_model.dart';
import 'package:smokeless_weather/utils/get_weather_img_name.dart';
import 'package:smokeless_weather/widgets/daily_view.dart';

import 'package:smokeless_weather/widgets/hourly_view.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  late Future<TomorrowIoWeather> futureWeather;
  MinutelyHourly? selectedHour;
  Daily? selectedDay;

  String shortName(Location location) {
    List<String> nameParts = location.name.split(",");
    if (nameParts.length < 3) {
      return location.name;
    }

    List<String> newNameList = [nameParts.first, nameParts.last];
    return newNameList.join(",");
  }

  Future<TomorrowIoWeather> fetchWeatherData() async {
    String url = "https://api.tomorrow.io/v4/weather/forecast?location=nanyuki&apikey=929vL1pLyInK3ZRp8Hc9oA8OzeGQmIFi";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> rawWeatherData = jsonDecode(response.body) as Map<String, dynamic>;

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
                title: Text(
                  shortName(weatherData.location),
                  style: const TextStyle(
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
                          bottomLeft: Radius.circular(MediaQuery.of(context).size.width / 8),
                          bottomRight: Radius.circular(MediaQuery.of(context).size.width / 8),
                        ),
                      ),
                      child: selectedDay != null
                          ? DailyView(daily: selectedDay ?? weatherData.timelines.daily.first)
                          : HourlyView(
                              minutelyHourly: selectedHour ?? weatherData.timelines.hourly.first,
                            ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 21, 10, 10),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Today",
                                    style: TextStyle(color: Colors.white, fontSize: 21),
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
                                height: 185,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children: [
                                    ...weatherData.timelines.hourly.map(
                                      (MinutelyHourly e) => TextButton(
                                        style: TextButton.styleFrom(padding: EdgeInsets.all(8)),
                                        onPressed: () {
                                          log("Pressed day column at time ${e.time.hour}");
                                          setState(() {
                                            selectedHour = e;
                                            selectedDay = null;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white24,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(17),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                DateFormat.E().format(e.time),
                                                style: TextStyle(color: Colors.white70, fontSize: 16),
                                              ),
                                              Text(
                                                displayTime(e.time.hour),
                                                style: TextStyle(color: Colors.white54, fontSize: 16),
                                              ),
                                              Image.asset(
                                                "assets/img/weather_icons/${getWeatherImgName(e.minutelyHourlyValues.weatherCode)}.png",
                                                width: 80,
                                              ),
                                              Text(
                                                "${e.minutelyHourlyValues.temperature}\u00B0",
                                                style: TextStyle(color: Colors.white, fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "This Week",
                                    style: TextStyle(color: Colors.white, fontSize: 21),
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
                                height: 185,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children: [
                                    ...weatherData.timelines.daily.map(
                                      (Daily e) => TextButton(
                                        style: TextButton.styleFrom(padding: EdgeInsets.all(8)),
                                        onPressed: () {
                                          log("Pressed day column at ${e.time}");
                                          setState(() {
                                            selectedDay = e;
                                            selectedHour = null;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white24,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(17),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                DateFormat.E().format(e.time), // Short weekday name (e.g., Mon, Tue)
                                                style: TextStyle(color: Colors.white70, fontSize: 16),
                                              ),
                                              Text(
                                                DateFormat.MMMd().format(e.time), // Date (e.g., Feb 13)
                                                style: TextStyle(color: Colors.white54, fontSize: 14),
                                              ),
                                              Image.asset(
                                                "assets/img/weather_icons/${getWeatherImgName(e.dailyValues.weatherCodeMax)}.png",
                                                width: 80,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${e.dailyValues.temperatureMin}\u00B0",
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                  ),
                                                  Text("/"),
                                                  Text(
                                                    "${e.dailyValues.temperatureApparentMax}\u00B0",
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
