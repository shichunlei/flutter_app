import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/weather/weather/WeatherData.dart';

class WeatherPage extends StatefulWidget {
  String cityname;

  WeatherPage(this.cityname);

  @override
  State<StatefulWidget> createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  WeatherData weather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.cityname);
    _getWeather(widget.cityname);
  }

  /// 根据城市名查询该城市天气预报
  _getWeather(String cityname) async {
    var httpClient = new HttpClient();
    var url =
        "https://free-api.heweather.net/s6/weather/now?key=ebb698e9bb6844199e6fd23cbb9a77c5&location=${cityname}";

    print(url);

    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonData = await response.transform(utf8.decoder).join();

      /// setState 相当于 runOnUiThread
      setState(() {
        weather = WeatherData.decodeData(jsonData.toString());
        print(weather);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var content;
    if (weather == null) {
      content = new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      content = Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'images/weather_bg.jpg',
            fit: BoxFit.fitHeight,
          ),
          Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 40.0),
                child: new Text(
                  widget.cityname,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
              ),
              Container(
                child: Image.network(
                  weather.cond_code,
                ),
                alignment: Alignment.centerRight,
              ),
              Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Text(weather.tmp,
                        style:
                            new TextStyle(color: Colors.white, fontSize: 80.0)),
                    Text("${weather.cond_txt}",
                        style:
                            new TextStyle(color: Colors.white, fontSize: 45.0)),
                    Text(
                      weather.hum,
                      style: new TextStyle(color: Colors.white, fontSize: 30.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }

    // TODO: implement build
    return new Scaffold(
//      appBar: AppBar(
//        title: Text(widget.cityname),
//      ),
      body: content,
    );
  }
}
