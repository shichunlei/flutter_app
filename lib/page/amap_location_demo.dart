import 'dart:convert';

import 'package:amap_base_location/amap_base_location.dart';
import 'package:flutter/material.dart';

import '../page_index.dart';

class AMapLocationDemo extends StatefulWidget {
  AMapLocationDemo({Key key}) : super(key: key);

  @override
  createState() => _AMapLocationDemoState();
}

class _AMapLocationDemoState extends State<AMapLocationDemo>
    with AutomaticKeepAliveClientMixin {
  final _amapLocation = AMapLocation();

  List<Location> _result = [];

  @override
  void initState() {
    super.initState();

    _amapLocation.init();
  }

  @override
  void dispose() {
    _amapLocation.stopLocate();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[

          Expanded(
            child: ListView(
              children:
                  _result.map((location) => _ResultItem(location)).toList(),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Button(
                      onPressed: () async {
                        final options = LocationClientOptions(
                          isOnceLocation: true,
                          locatingWithReGeocode: true,
                        );

                        if (await Permissions.requestMapPermission()) {
                          _amapLocation
                              .getLocation(options)
                              .then(_result.add)
                              .then((_) => setState(() {}));
                        } else {
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text('权限不足')));
                        }
                      },
                      text: '单次定位')),
              Expanded(
                  child: Button(
                    text: '连续定位',
                    onPressed: () async {
                      final options = LocationClientOptions(
                        isOnceLocation: false,
                        locatingWithReGeocode: true,
                      );

                      if (await Permissions.requestMapPermission()) {
                        _amapLocation
                            .startLocate(options)
                            .map(_result.add)
                            .listen((_) => setState(() {}));
                      } else {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('权限不足')));
                      }
                    },
                  )),
              Expanded(
                  child: Button(
                    text: '停止定位',
                    onPressed: () {
                      _amapLocation.stopLocate();
                    },
                  ))
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ResultItem extends StatelessWidget {
  final Location _data;

  const _ResultItem(this._data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(DateTime.now().toIso8601String(),
              style: TextStyle(color: Colors.grey, fontSize: 16)),
          Text(jsonFormat(_data.toJson()),
              style: TextStyle(color: Colors.white, fontSize: 14))
        ],
      ),
    );
  }

  String jsonFormat(Map<String, Object> json) {
    JsonEncoder encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(json);
  }
}
