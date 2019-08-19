import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/bean/city.dart';

import 'package:rounded_letter/rounded_letter.dart';

import '../../page_index.dart';

class CityPage extends StatefulWidget {
  final String currentCity;

  CityPage({Key key, this.currentCity}) : super(key: key);

  @override
  createState() => CityPageState();
}

class CityPageState extends State<CityPage> {
  List<City> _cityList = [];
  List<City> _hotCityList = [];

  int _suspensionHeight = 40;
  int _itemHeight = 58;
  String _suspensionTag = "";

  LoaderState _status = LoaderState.Loading;

  @override
  void initState() {
    super.initState();
    getCityListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('城市列表')),
        body: LoaderContainer(
          loaderState: _status,
          loadingView: getLoadingWidget(),
          contentView: AzListView(
              data: _cityList,
              topData: _hotCityList,
              itemBuilder: (context, cityBean) => _buildCityItems(cityBean),
              suspensionWidget: SuspensionTag(
                  susTag: _suspensionTag, susHeight: _suspensionHeight),
              isUseRealIndex: true,
              itemHeight: _itemHeight,
              suspensionHeight: _suspensionHeight,
              indexBarBuilder: (context, list, onTouch) => IndexBar(
                  onTouch: onTouch,
                  data: list,
                  touchDownColor: Colors.transparent,
                  textStyle: TextStyles.textGray12),
              onSusTagChanged: (value) =>
                  setState(() => _suspensionTag = value)),
        ));
  }

  void getCityListData() async {
    _hotCityList
        .add(City(location: "${widget.currentCity}", firstLetter: "定位"));
    _hotCityList
        .add(City(location: "${widget.currentCity}", firstLetter: "常用"));
    _hotCityList.add(City(location: "北京", firstLetter: "常用"));
    _hotCityList.add(City(location: "广州", firstLetter: "热门"));
    _hotCityList.add(City(location: "成都", firstLetter: "热门"));
    _hotCityList.add(City(location: "深圳", firstLetter: "热门"));
    _hotCityList.add(City(location: "杭州", firstLetter: "热门"));
    _hotCityList.add(City(location: "上海", firstLetter: "热门"));

    _cityList = await ApiService.getHotCities();

    /// 根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_cityList);

    _suspensionTag = _hotCityList[0].getSuspensionTag();

    setState(() {
      _status = LoaderState.Succeed;
    });
  }

  /// 构建列表 item Widget.
  _buildCityItems(City model) {
    String susTag = model.getSuspensionTag();
    susTag = (susTag == "★" ? "热门城市" : susTag);
    return Column(children: <Widget>[
      Offstage(
          offstage: !(model.isShowSuspension == true),
          child: SuspensionTag(susTag: susTag, susHeight: _suspensionHeight)),
      SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
              title: Text(model.location),
              leading:
                  RoundedLetter.withRandomColors(model.location[0], 40, 20),
              onTap: () => pushNewPage(context, WeatherPage(model.location))))
    ]);
  }
}
