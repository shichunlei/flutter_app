import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:flutter_app/city_pickers/bean/picker_item.dart';
import 'package:flutter_app/city_pickers/ui/attr_item_container.dart';
import 'package:flutter_app/city_pickers/ui/location_selector.dart';
import 'package:flutter_app/city_pickers/ui/picker.dart';

class IosCityPickersPage extends StatefulWidget {
  @override
  _IosCityPickersPageState createState() => _IosCityPickersPageState();
}

class _IosCityPickersPageState extends State<IosCityPickersPage> {
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
        title: Text('iOS风格城市选择器'),
      ),
      body: Column(
        children: <Widget>[
          AttrItemContainer(title: '级联方式', child: _buildShowTypes()),
          AttrItemContainer(title: '默认地址', child: _buildDefaultLocation()),
          AttrItemContainer(title: '背景透明度', child: _buildBarrierOpacity()),
          AttrItemContainer(title: '背景点击关闭', child: _buildBarrierDismissible()),
          AttrItemContainer(title: '主题选择', child: _buildTheme()),
          AttrItemContainer(title: '选择结果', child: Text("${result.toString()}")),
          RaisedButton(
            onPressed: () async {
              print("locationCode $resultAttr");
              Result tempResult = await CityPickers.showCityPicker(

                  /// 上下文
                  context: context,

                  /// 主题
                  theme: themeAttr != null ? themeAttr.value : null,

                  /// 初始化地址信息, 可以是省, 市, 区的地区码
                  locationCode: resultAttr != null
                      ? resultAttr.areaId ??
                          resultAttr.cityId ??
                          resultAttr.provinceId
                      : null,

                  /// 三级联动，显示类型
                  showType: showTypeAttr.value,

                  /// 弹出层的背景透明度, 应该是大于0, 小于1
                  barrierOpacity: barrierOpacityAttr,

                  /// 是否可以通过点击弹出层背景, 关闭弹出层
                  barrierDismissible: barrierDismissibleAttr);
              if (tempResult == null) {
                return;
              }
              this.setState(() {
                result = tempResult;
              });
            },
            child: Text("展示city picker"),
          )
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
                // ignore: undefined_method
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
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

  Widget _buildBarrierDismissible() {
    return Container(
        alignment: Alignment.centerRight,
        child: CupertinoSwitch(
          value: barrierDismissibleAttr,
          onChanged: (bool val) {
            this.setState(() {
              barrierDismissibleAttr = !barrierDismissibleAttr;
            });
          },
        ));
  }

  Widget _buildBarrierOpacity() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: CupertinoSlider(
            value: barrierOpacityAttr,
            //实际进度的位置
            min: 0.01,
            max: 1.0,
            divisions: 100,
            activeColor: Colors.blue,
            //进度中活动部分的颜色
            onChanged: (double) {
              setState(() {
                barrierOpacityAttr = double.toDouble();
              });
            },
          ),
        ),
        Text("${barrierOpacityAttr.toStringAsFixed(2)}")
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
