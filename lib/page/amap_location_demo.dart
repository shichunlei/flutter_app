import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:flutter/material.dart';

import '../page_index.dart';

class AMapLocationDemo extends StatefulWidget {
  AMapLocationDemo({Key key}) : super(key: key);

  @override
  createState() => _AMapLocationDemoState();
}

class _AMapLocationDemoState extends State<AMapLocationDemo>
    with AutomaticKeepAliveClientMixin {
  List<Map<String, dynamic>> _result = [];

  Map<String, dynamic> map = {};

  @override
  void dispose() {
    AmapLocation.stopLocation();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: Text('高德地图定位')),
      body: Column(children: <Widget>[
        Expanded(
            child: ListView(
                children: _result.map((item) => _ResultItem(item)).toList())),
        Row(children: <Widget>[
          Expanded(
              child: Button(
                  onPressed: () async {
                    if (await PermissionsUtil.requestMapPermission()) {
                      final location = await AmapLocation.fetchLocation();

                      map = {
                        "time": DateTime.now().toIso8601String(),
                        "country": location.country,
                        "province": location.province,
                        "city": location.city,
                        "district": location.district,
                        "address": location.address,
                        "latitude": location.latLng.latitude,
                        "longitude": location.latLng.longitude,
                        "poiName": location.poiName,
                        "accuracy": location.accuracy,
                        "street": location.street,
                        "aoiName": location.aoiName,
                        "altitude": location.altitude,
                        "bearing": location.bearing,
                      };

                      _result.add(map);
                      setState(() {});
                    } else {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('权限不足')));
                    }
                  },
                  child: Text('单次定位'))),
          Expanded(
              child: Button(
                  child: Text('连续定位'),
                  onPressed: () async {
                    if (await PermissionsUtil.requestMapPermission()) {
                      await for (final location
                          in AmapLocation.listenLocation()) {
                        map = {
                          "time": DateTime.now().toIso8601String(),
                          "country": location.country,
                          "province": location.province,
                          "city": location.city,
                          "district": location.district,
                          "address": location.address,
                          "latitude": location.latLng.latitude,
                          "longitude": location.latLng.longitude,
                          "poiName": location.poiName,
                          "accuracy": location.accuracy,
                          "street": location.street,
                          "aoiName": location.aoiName,
                          "altitude": location.altitude,
                          "bearing": location.bearing,
                        };

                        _result.add(map);
                        setState(() {});
                      }
                    } else {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('权限不足')));
                    }
                  })),
          Expanded(
              child: Button(
                  child: Text('停止定位'),
                  onPressed: () async {
                    await AmapLocation.stopLocation();
                  }))
        ])
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ResultItem extends StatelessWidget {
  final Map<String, dynamic> map;

  const _ResultItem(this.map, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.pink),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: listPage(),
            mainAxisSize: MainAxisSize.min));
  }

  List<Widget> listPage() {
    List<Widget> views = [];

    map.forEach((key, value) {
      views.add(Text('$key: $value' ?? '', style: TextStyles.textWhite14));
    });

    return views;
  }
}
