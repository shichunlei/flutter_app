import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

class CityPage extends StatefulWidget {
  @override
  createState() => CityPageState();
}

class CityPageState extends State<CityPage> {
  List<City> _cityList = [];
  List<City> _hotCityList = [];

  int _suspensionHeight = 40;
  int _itemHeight = 58;

  LoaderState _status = LoaderState.Loading;

  String currentCity;

  @override
  void initState() {
    super.initState();
    currentCity = SpUtil.getString('current_city');
    getCityListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('城市列表')),
        body: LoaderContainer(
            loaderState: _status,
            loadingView: LoadingWidget(),
            contentView: AzListView(
                data: _cityList,
                itemCount: _cityList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildCityItems(_cityList[index]);
                },
                padding: EdgeInsets.zero,
                indexBarData: ['定', '常', '★', ...kIndexBarData])));
  }

  void getCityListData() async {
    _hotCityList.add(City(location: "$currentCity", firstLetter: "定"));
    _hotCityList.add(City(location: "$currentCity", firstLetter: "常"));
    _hotCityList.add(City(location: "北京", firstLetter: "常"));
    _hotCityList.add(City(location: "广州", firstLetter: "★"));
    _hotCityList.add(City(location: "成都", firstLetter: "★"));
    _hotCityList.add(City(location: "深圳", firstLetter: "★"));
    _hotCityList.add(City(location: "杭州", firstLetter: "★"));
    _hotCityList.add(City(location: "上海", firstLetter: "★"));

    List<City> __cityList = await WeatherRepository.getHotCities();

    _cityList.addAll(__cityList);

    /// 根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_cityList);

    _cityList.insertAll(0, _hotCityList);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(_cityList);

    setState(() {
      _status = LoaderState.Succeed;
    });
  }

  /// 构建列表 item Widget.
  _buildCityItems(City model) {
    String susTag = model.getSuspensionTag();
    susTag = (susTag == "★"
        ? "★ 热门城市"
        : susTag == "定"
            ? "当前定位"
            : susTag == "常"
                ? "常用地址"
                : susTag);
    return Column(children: <Widget>[
      Offstage(
          offstage: !(model.isShowSuspension == true),
          child: SuspensionTag(susTag: susTag, susHeight: _suspensionHeight)),
      SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
              title: Text(model.location),
              leading: RoundedLetter.withRandomColors(model.location[0], 40, 20),
              onTap: () => Navigator.of(context).pop(model.location)))
    ]);
  }
}
