import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/suspension_tag.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_app/bean/city.dart';
import 'package:flutter_app/weather/page/weather_page.dart';
import 'package:rounded_letter/rounded_letter.dart';

class CityPage extends StatefulWidget {
  @override
  createState() => CityPageState();
}

class CityPageState extends State<CityPage> {
  List<City> _cityList = [];
  List<City> _hotCityList = [];

  int _suspensionHeight = 40;
  int _itemHeight = 58;
  String _suspensionTag = "";

  @override
  void initState() {
    super.initState();
    getCityListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('城市列表')), body: _buildBodyView());
  }

  Widget _buildBodyView() {
    if (_cityList.isEmpty) return getLoadingWidget();
    return Column(children: <Widget>[
      GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => pushNewPage(context, WeatherPage('北京')),
          child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(15.0),
              child: Text("当前城市: 北京"))),
      Expanded(
          child: AzListView(
              data: _cityList,
              topData: _hotCityList,
              itemBuilder: (context, cityBean) => _buildCityItems(cityBean),
              suspensionWidget: SuspensionTag(
                  susTag: _suspensionTag, susHeight: _suspensionHeight),
              isUseRealIndex: true,
              itemHeight: _itemHeight,
              suspensionHeight: _suspensionHeight,
              onSusTagChanged: (value) =>
                  setState(() => _suspensionTag = value)))
    ]);
  }

  void getCityListData() async {
    _hotCityList.add(City(parent_city: "北京", tagIndex: "热门"));
    _hotCityList.add(City(parent_city: "广州", tagIndex: "热门"));
    _hotCityList.add(City(parent_city: "成都", tagIndex: "热门"));
    _hotCityList.add(City(parent_city: "深圳", tagIndex: "热门"));
    _hotCityList.add(City(parent_city: "杭州", tagIndex: "热门"));
    _hotCityList.add(City(parent_city: "上海", tagIndex: "热门"));

    _cityList = await ApiService.getHotCitys();
    _handleList(_cityList);

    _suspensionTag = _hotCityList[0].getSuspensionTag();

    setState(() {});
  }

  void _handleList(List<City> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = list[i].namePinyin;
      String tag = pinyin[0].toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }

    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_cityList);
  }

  /// 构建列表 item Widget.
  _buildCityItems(model) {
    String susTag = model.getSuspensionTag();
    susTag = (susTag == "★" ? "热门城市" : susTag);
    return Column(children: <Widget>[
      Offstage(
          offstage: !(model.isShowSuspension == true),
          child: SuspensionTag(susTag: susTag, susHeight: _suspensionHeight)),
      SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
              title: Text(model.parent_city),
              leading:
                  RoundedLetter.withRandomColors(model.parent_city[0], 40, 20),
              onTap: () =>
                  pushNewPage(context, WeatherPage(model.parent_city))))
    ]);
  }
}
