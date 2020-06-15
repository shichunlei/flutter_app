import 'package:flutter/material.dart';
import '../../delegates/search_city_delegate.dart';
import '../../page_index.dart';
import '../../store/index.dart';
import '../../res/styles.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CityManagerPage extends StatelessWidget {
  CityManagerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Store.value<WeatherModel>(context);

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('城市管理')),
        body: EasyRefresh(
            child: ListView.separated(
                itemBuilder: (_, index) {
                  return Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      clipBehavior: Clip.antiAlias,
                      child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                              onTap: () => Navigator.pop(context,
                                  provider.citiesWeather[index].city.location),
                              onLongPress: () {
                                if (provider
                                        .citiesWeather[index].city.location !=
                                    provider.defaultCity) {
                                  showDiffDialog(context,
                                      title: const Text('删除'),
                                      content: Text(
                                          '您确定要删除${provider.citiesWeather[index].city.location}吗？'),
                                      pressed: () {
                                    provider.deleteCity(index);
                                    Navigator.of(context).pop();
                                  });
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(children: <Widget>[
                                          Visibility(
                                              child: Icon(Icons.location_on),
                                              visible: provider
                                                      .citiesWeather[index]
                                                      .city
                                                      .location ==
                                                  provider.defaultCity),
                                          Text(
                                              '${provider.citiesWeather[index].city.location}(${provider.citiesWeather[index].city.adminArea})')
                                        ]),
                                        Gaps.vGap5,
                                        Row(
                                            children: <Widget>[
                                              Text(
                                                  '${provider.citiesWeather[index].now.tmp} ℃'),
                                              Text(
                                                  '${provider.citiesWeather[index].now.condTxt}'),
                                              ImageLoadView(
                                                  '${provider.citiesWeather[index].now.condIcon}',
                                                  width: 30,
                                                  height: 30)
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly)
                                      ])))));
                },
                itemCount: provider.citiesWeather.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Gaps.vGap5)),
        floatingActionButton: FloatingActionButton(
            onPressed: () =>
                showSearch(context: context, delegate: SearchCityDelegate()),
            child: Icon(Icons.add)));
  }
}
