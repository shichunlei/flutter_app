import 'dart:convert';
import 'dart:io';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/contact/ui/suspension_tag.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/weather/city/city_data.dart';
import 'package:flutter_app/weather/weather/WeatherPage.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:rounded_letter/rounded_letter.dart';

class CityPage extends StatefulWidget {
  @override
  createState() => CityPageState();
}

class CityPageState extends State<CityPage> {
  List<CityData> _cityList = [];
  List<CityData> _hotCityList = [];

  int _suspensionHeight = 40;
  int _itemHeight = 50;
  String _suspensionTag = "";

  @override
  void initState() {
    super.initState();
    getCityListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('城市列表')),
      body: Stack(
        children: <Widget>[
          Offstage(
            /// 默认为true，也就是不显示，当为flase的时候，会显示该控件
            offstage: _cityList.isNotEmpty,
            child: Center(
              child: getLoadingWidget(),
            ),
          ),
          Offstage(
            offstage: _cityList.isEmpty,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 15.0),
                  height: _itemHeight.toDouble(),
                  child: Text("当前城市: 北京"),
                ),
                Expanded(
                  child: AzListView(
                    data: _cityList,
                    topData: _hotCityList,
                    itemBuilder: (context, cityBean) =>
                        _buildCityItems(cityBean),
                    suspensionWidget: SuspensionTag(
                      susTag: _suspensionTag,
                      susHeight: _suspensionHeight,
                    ),
                    isUseRealIndex: true,
                    itemHeight: _itemHeight,
                    suspensionHeight: _suspensionHeight,
                    onSusTagChanged: _onSusTagChanged,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getCityListData() async {
    _hotCityList.add(CityData(parent_city: "北京", tagIndex: "热门"));
    _hotCityList.add(CityData(parent_city: "广州", tagIndex: "热门"));
    _hotCityList.add(CityData(parent_city: "成都", tagIndex: "热门"));
    _hotCityList.add(CityData(parent_city: "深圳", tagIndex: "热门"));
    _hotCityList.add(CityData(parent_city: "杭州", tagIndex: "热门"));
    _hotCityList.add(CityData(parent_city: "上海", tagIndex: "热门"));

    var httpClient = HttpClient();
    var url =
        "https://search.heweather.net/top?group=cn&key=ebb698e9bb6844199e6fd23cbb9a77c5&number=50";

    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonData = await response.transform(utf8.decoder).join();

      _cityList = CityData.decodeData(jsonData.toString());
      _handleList(_cityList);

      // setState 相当于 runOnUiThread
      setState(() {
        _suspensionTag = _hotCityList[0].getSuspensionTag();
      });
    }
  }

  void _handleList(List<CityData> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].parent_city);
      String tag = pinyin.substring(0, 1).toUpperCase();
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
    return Column(
      children: <Widget>[
        Offstage(
          offstage: !(model.isShowSuspension == true),
          child: SuspensionTag(
            susTag: susTag,
            susHeight: _suspensionHeight,
          ),
        ),
        SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
            title: Text(
              model.parent_city,
            ),
            leading: RoundedLetter.withRandomColors(
                model.parent_city.substring(0, 1), 40, 20),
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        WeatherPage(model.parent_city),
                  ),
                ),
          ),
        ),
      ],
    );
  }

  void _onSusTagChanged(String value) {
    setState(() {
      _suspensionTag = value;
    });
  }
}
