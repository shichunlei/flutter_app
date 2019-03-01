import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/city_pickers/ui/attr_item_container.dart';
import 'package:flutter_app/city_pickers/ui/picker.dart';
import 'package:flutter_app/city_pickers/bean/picker_item.dart';
import 'package:flutter_app/city_pickers/ui/location_selector.dart';

var emptyResult = Result();

class FullpageCityPickersPage extends StatefulWidget {
  @override
  _FullpageCityPickersPageState createState() =>
      _FullpageCityPickersPageState();
}

class _FullpageCityPickersPageState extends State<FullpageCityPickersPage> {
  PickerItem showTypeAttr = PickerItem(name: '省+市+县', value: ShowType.pca);
  Result resultAttr = Result();
  Result result = Result();
  double barrierOpacityAttr = 0.5;
  bool barrierDismissibleAttr = false;
  PickerItem themeAttr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(''),
      ),
      body: Column(
        children: <Widget>[
          AttrItemContainer(title: '级联方式', child: _buildShowTypes()),
          AttrItemContainer(title: '默认地址', child: _buildDefaultLocation()),
          AttrItemContainer(title: '主题选择', child: _buildTheme()),
          AttrItemContainer(title: '选择结果', child: Text("${result.toString()}")),
          RaisedButton(
            onPressed: () async {
              print("locationCode $resultAttr");
              Result tempResult = await CityPickers.showFullPageCityPicker(
                context: context,
                theme: themeAttr != null ? themeAttr.value : null,
                locationCode: resultAttr != null
                    ? resultAttr.areaId ??
                        resultAttr.cityId ??
                        resultAttr.provinceId
                    : null,
                showType: showTypeAttr.value,
              );
              if (tempResult == null) {
                return;
              }
              this.setState(() {
                result = tempResult;
              });
            },
            child: Text("展示city picker"),
          ),
        ],
      ),
    );
  }

  Widget _buildShowTypes() {
    return Picker(
      target: showTypeAttr != null && showTypeAttr.name != null
          ? Text(showTypeAttr.name)
          : Text("显示几级联动"),
      onConfirm: (PickerItem item) {
        setState(() {
          showTypeAttr = item;
        });
      },
      items: [
        PickerItem(name: '省', value: ShowType.p),
        PickerItem(name: '市', value: ShowType.c),
        PickerItem(name: '县', value: ShowType.a),
        PickerItem(name: '省+市', value: ShowType.pc),
        PickerItem(name: '省+市+县', value: ShowType.pca),
        PickerItem(name: '市+县', value: ShowType.ca),
      ],
    );
  }

  Widget _buildDefaultLocation() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: LocationSelector(
            target: Text("${resultAttr.provinceName ?? '省'}",
                maxLines: 1, overflow: TextOverflow.ellipsis),
            showType: ShowType.p,
            initResult: resultAttr,
            onConfirm: (Result result) {
              if (result.provinceId != null) {
                this.setState(() {
                  resultAttr = result;
                });
              }
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: LocationSelector(
            target: Text("${resultAttr.cityName ?? '市'}",
                maxLines: 1, overflow: TextOverflow.ellipsis),
            showType: ShowType.c,
            initResult: resultAttr,
            onConfirm: (Result result) {
              if (result.cityId != null) {
                setState(() {
                  resultAttr = result;
                });
              }
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: LocationSelector(
            target: Text("${resultAttr.areaName ?? '区'}",
                maxLines: 1, overflow: TextOverflow.ellipsis),
            showType: ShowType.a,
            initResult: resultAttr,
            onConfirm: (Result result) {
              if (result.areaId != null) {
                setState(() {
                  resultAttr = result;
                });
              }
            },
          ),
        )
      ],
    );
  }

  Widget _buildTheme() {
    return Picker(
        target: themeAttr != null && themeAttr.name != null
            ? Text(themeAttr.name)
            : Text("主题切换"),
        onConfirm: (PickerItem item) {
          setState(() {
            themeAttr = item;
          });
        },
        items: [
          PickerItem(name: 'ThemeData.light()', value: ThemeData.light()),
          PickerItem(name: 'ThemeData.fallback()', value: ThemeData.fallback()),
          PickerItem(name: 'ThemeData.dark()', value: ThemeData.dark()),
          PickerItem(name: 'ThemeData.of(context)', value: null),
        ]);
  }
}
