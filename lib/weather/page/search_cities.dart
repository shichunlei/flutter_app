import 'package:flutter/material.dart';
import 'package:flutter_app/bean/index.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_app/store/index.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class SearchCitiesPage extends StatefulWidget {
  final String query;

  SearchCitiesPage({Key key, this.query}) : super(key: key);

  @override
  createState() => _SearchCitiesPageState();
}

class _SearchCitiesPageState extends State<SearchCitiesPage> {
  List<City> cities = [];

  @override
  void initState() {
    super.initState();

    searchCities(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Store.value<WeatherModel>(context);

    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: EasyRefresh(
            child: ListView.separated(
                itemBuilder: (_, index) {
                  return Material(
                      color: Colors.white,
                      child: InkWell(
                          onTap: () {
                            showLoadingDialog(context, '加载中...');
                            getCityWeather(cities[index].location, provider);
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              alignment: Alignment.center,
                              child: Row(children: <Widget>[
                                Visibility(
                                    child: Icon(Icons.location_on),
                                    visible: cities[index].location ==
                                        provider.defaultCity),
                                Text(
                                    '${cities[index].location}(${cities[index].adminArea})')
                              ]))));
                },
                separatorBuilder: (_, index) => Gaps.vGap5,
                itemCount: cities.length)));
  }

  void searchCities(String query) async {
    List<City> list = await ApiService.getSearchCities(query);

    cities.clear();
    cities.addAll(list);

    setState(() {});
  }

  void getCityWeather(String cityName, provider) async {
    HeWeather weather = await ApiService.getHeWeather(cityName);

    // 关闭加载框
    Navigator.pop(context);

    provider.addCityWeather(weather);

    Navigator.pop(context);
  }
}
