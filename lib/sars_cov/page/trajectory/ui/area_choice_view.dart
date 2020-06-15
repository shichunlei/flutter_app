import 'package:flutter/material.dart';

class AreaChoiceView extends StatelessWidget {
  final Function(String) onProvinceCallBack;
  final Function(String) onCityCallBack;
  final Function(String) onCountyCallBack;

  AreaChoiceView(
      {Key key,
      this.onProvinceCallBack,
      this.onCityCallBack,
      this.onCountyCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  onProvinceCallBack("");
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Text(
                        '全国',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  onCityCallBack("");
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Text(
                        '全部',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  onCountyCallBack("");
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Text(
                        '全部',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
