import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:smokeless_weather/models/tomorrow_io_weather_model.dart';
import 'package:smokeless_weather/utils/get_weather_condition.dart';
import 'package:smokeless_weather/utils/get_weather_img_name.dart';

class DailyView extends StatelessWidget {
  final Daily daily;
  const DailyView({super.key, required this.daily});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.height / 2 - 150),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(0, -0.5),
                    child: Row(
                      children: [
                        Text(
                          getWeatherCondition(daily.dailyValues.weatherCodeMax),
                          style: TextStyle(color: Colors.white54, fontSize: 10),
                        ),
                        Text(
                          getWeatherCondition(daily.dailyValues.weatherCodeMin),
                          style: TextStyle(color: Colors.white54, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment(-1, 0.5),
                    child: Row(
                      children: [
                        Text(
                          "${daily.dailyValues.temperatureMin}\u00B0",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "/",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "${daily.dailyValues.temperatureMax}\u00B0",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/img/weather_icons/${getWeatherImgName(daily.dailyValues.weatherCodeMax)}@2x.png",
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        MdiIcons.weatherWindy,
                        color: Colors.white54,
                      ),
                      Text(
                        "Wind",
                        style: TextStyle(color: Colors.white54),
                      ),
                      Row(
                        children: [
                          Text(
                            "${daily.dailyValues.windSpeedMin}KM/hr",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "/",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${daily.dailyValues.windSpeedMax}KM/hr",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        MdiIcons.waterPercent,
                        color: Colors.white54,
                      ),
                      Text(
                        "Humidity",
                        style: TextStyle(color: Colors.white54),
                      ),
                      Row(
                        children: [
                          Text(
                            "${daily.dailyValues.humidityMin}%",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "/",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${daily.dailyValues.humidityMax}%",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.visibility,
                        size: 25,
                        color: Colors.white54,
                      ),
                      Text(
                        "Visibility",
                        style: TextStyle(color: Colors.white54),
                      ),
                      Row(
                        children: [
                          Text(
                            "${daily.dailyValues.visibilityMin}KM",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "/",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${daily.dailyValues.visibilityMax}KM",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
