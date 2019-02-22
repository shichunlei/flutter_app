import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';

class LocationSelector extends StatelessWidget {
  /// 触发对象
  final Widget target;

  /// 显示类型
  final ShowType showType;

  /// 确认
  final ValueChanged<Result> onConfirm;

  /// initResult type[Result]
  final Result initResult;

  LocationSelector(
      {this.showType = ShowType.pca,
      this.initResult,
      @required this.target,
      @required this.onConfirm});

  show(BuildContext context) async {
    Result result = await CityPickers.showCityPicker(
        context: context,
        locationCode: initResult != null
            ? initResult.areaId ?? initResult.cityId ?? initResult.provinceId
            : null,
        showType: showType);
    if (result != null) {
      onConfirm(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        show(context);
      },
      child: Container(
        color: Colors.black12,
        alignment: Alignment.center,
        margin: EdgeInsets.all(3.0),
        child: target,
      ),
    );
  }
}
