import 'package:flutter/material.dart';
import 'package:flutter_app/bean/he_weather.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/utils/sp_util.dart';

class WeatherModel extends ChangeNotifier {
  List<HeWeather> _citiesWeather = [];

  List<HeWeather> get citiesWeather => _citiesWeather;

  String _defaultCity = '正在定位...';

  String get defaultCity => _defaultCity;

  HeWeather get defaultWeather => _defaultWeather;

  HeWeather _defaultWeather;

  /// 得到当前定位城市的天气情况
  Future getDefaultCityWeather(String cityName) async {
    _defaultCity = cityName;

    /// 得到定位城市的当前天气情况
    await getCityNowWeather(cityName, isDefault: true);
  }

  /// 得到城市当前天气情况
  Future getCityNowWeather(String cityName, {bool isDefault: false}) async {
    HeWeather weather = await ApiService.getHeWeatherNow(cityName);

    if (isDefault) {
      _defaultWeather = weather;
      _defaultCity = weather.city.location;

      /// 保存定位地区
      SpUtil.setString("current_city", _defaultCity);

      _citiesWeather.insert(0, _defaultWeather);
    }

    notifyListeners();
  }

  /// 得到城市天气情况（全部）
  Future getCityWeather(String cityName) async {
    HeWeather weather = await ApiService.getHeWeather(cityName);
    notifyListeners();
  }

  /// 收藏城市
  Future addCityWeather(HeWeather weather) async {
    bool isExist = false;

    _citiesWeather.forEach((item) {
      /// 存在该城市天气情况，更新不添加
      if (item.city.location == weather.city.location) {
        isExist = true;
      }
    });

    /// 不存在改城市天气情况，添加
    if (!isExist) {
      _citiesWeather.add(weather);
    }

    notifyListeners();
  }

  /// 删除收藏的城市及天气情况
  Future deleteCity(int index) async {
    _citiesWeather.removeAt(index);

    notifyListeners();
  }
}
