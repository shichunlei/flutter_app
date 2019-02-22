import 'package:flutter/material.dart';
import 'package:city_picker/city_picker.dart';

class CityPickerPage extends StatefulWidget {
  @override
  _CityPickerPageState createState() => _CityPickerPageState();
}

class _CityPickerPageState extends State<CityPickerPage> {
  String text;

  String province;
  String city;
  String county;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('中国城市选择'),
      ),
      body: Center(
        child: Text(
          text ?? "",
          style: Theme.of(context).textTheme.display1,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
        tooltip: '选择城市',
      ),
    );
  }

  void _incrementCounter() async {
    CityResult result = await showCityPicker(context,
        initCity: CityResult()
          ..province = province
          ..city = city
          ..county = county);

    if (result == null) {
      return;
    }

    province = result?.province;
    city = result?.city;
    county = result?.county;

    setState(() {
      text = "$province - $city - $county";
    });
  }
}
