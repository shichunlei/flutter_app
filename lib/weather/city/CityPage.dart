import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/weather/city/CityData.dart';
import 'package:flutter_app/weather/weather/WeatherPage.dart';

class CityPage extends StatefulWidget {
  @override
  createState() => CityPageState();
}

class CityPageState extends State<CityPage> {
  List<CityData> citylist = new List<CityData>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCityListData();
  }

  @override
  Widget build(BuildContext context) {
    var content;
    if (citylist.isEmpty) {
      content = Center(
        // 可选参数 child:
        child: CircularProgressIndicator(),
      );
    } else {
      content = ListView.builder(
        /// 一个创建item Widget的函数：Widget Function(BuildContext context, int index)，通过实现改函数来创建item内容，index表示条目的位置索引。
        itemBuilder: (context, index) {
          return buildCityItems(index);
        },

        /// 表示列表的条目总数量。
        itemCount: citylist.length,
      );
    }

    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text('城市列表'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              print("点击了刷新按钮");
            },
          )
        ],
      ),
      body: content,
    );
  }

  getCityListData() async {
    var httpClient = new HttpClient();
    var url =
        "https://search.heweather.net/top?group=cn&key=ebb698e9bb6844199e6fd23cbb9a77c5&number=30";

    print(url);

    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonData = await response.transform(utf8.decoder).join();

      // setState 相当于 runOnUiThread
      setState(() {
        citylist = CityData.decodeData(jsonData.toString());
      });
    }
  }

  buildCityItems(index) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Card(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      citylist[index].parent_city,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.lightBlue,
                      ),
                    ),
                    height: 50.0,
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
          Divider(),
        ],
      ),
      onTap: () {
        print("${citylist[index].parent_city}被点击了");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                WeatherPage(citylist[index].parent_city),
          ),
        );
      },
    );
  }
}
