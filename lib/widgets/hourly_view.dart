import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:smokeless_weather/models/tomorrow_io_weather_model.dart';
import 'package:smokeless_weather/utils/get_weather_condition.dart';
import 'package:smokeless_weather/utils/get_weather_img_name.dart';

class HourlyView extends StatelessWidget {
  final MinutelyHourly minutelyHourly;
  const HourlyView({super.key, required this.minutelyHourly});

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
                    alignment: Alignment(0, -0.7),
                    child: Text(
                      getWeatherCondition(minutelyHourly.minutelyHourlyValues.weatherCode),
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, -0.5),
                    child: Text(
                      "${minutelyHourly.minutelyHourlyValues.temperature}\u00B0",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 85,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      "assets/img/weather_icons/${getWeatherImgName(minutelyHourly.minutelyHourlyValues.weatherCode)}@2x.png",
                      fit: BoxFit.cover,
                      scale: .75,
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
                        "${minutelyHourly.minutelyHourlyValues.windSpeed}KM/hr",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Wind",
                        style: TextStyle(color: Colors.white54),
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
                        "${minutelyHourly.minutelyHourlyValues.humidity}%",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Humidity",
                        style: TextStyle(color: Colors.white54),
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
                        "${minutelyHourly.minutelyHourlyValues.visibility}KM",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Visibility",
                        style: TextStyle(color: Colors.white54),
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
