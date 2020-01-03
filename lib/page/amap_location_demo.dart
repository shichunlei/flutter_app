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
  List<Location> _result = [];

  @override
  void dispose() {
    AmapLocation.stopLocation();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                        if (await PermissionsUtil.requestMapPermission()) {
                          final location = await AmapLocation.fetchLocation();
                          _result.add(location);
                          setState(() {});
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
                  if (await PermissionsUtil.requestMapPermission()) {
                    await for (final location
                        in AmapLocation.listenLocation()) {
                      _result.add(location);
                      setState(() {});
                    }
                  } else {
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('权限不足')));
                  }
                },
              )),
              Expanded(
                child: Button(
                  text: '停止定位',
                  onPressed: () async {
                    await AmapLocation.stopLocation();
                  },
                ),
              )
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
  final Location _location;

  const _ResultItem(this._location, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(DateTime.now().toIso8601String(),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  decoration: TextDecoration.none)),
          if (_location != null)
            FutureBuilder<String>(
              initialData: '',
              future: _location.address,
              builder: (_, ss) => Text(
                'address: ${ss.data}' ?? '',
                style: TextStyles.textWhite14,
              ),
            ),
          if (_location != null)
            FutureBuilder<String>(
              initialData: '',
              future: _location.country,
              builder: (_, ss) => Text(
                'country: ${ss.data}' ?? '',
                style: TextStyles.textWhite14,
              ),
            ),
          if (_location != null)
            FutureBuilder<String>(
              initialData: '',
              future: _location.province,
              builder: (_, ss) => Text(
                'province: ${ss.data}' ?? '',
                style: TextStyles.textWhite14,
              ),
            ),
          if (_location != null)
            FutureBuilder<String>(
              initialData: '',
              future: _location.city,
              builder: (_, ss) => Text(
                'city: ${ss.data}' ?? '',
                style: TextStyles.textWhite14,
              ),
            ),
          if (_location != null)
            FutureBuilder<String>(
              initialData: '',
              future: _location.district,
              builder: (_, ss) => Text(
                'district: ${ss.data}' ?? '',
                style: TextStyles.textWhite14,
              ),
            ),
          if (_location != null)
            FutureBuilder<String>(
              initialData: '',
              future: _location.poiName,
              builder: (_, ss) => Text(
                'poiName: ${ss.data}' ?? '',
                style: TextStyles.textWhite14,
              ),
            ),
          if (_location != null)
            FutureBuilder<String>(
              initialData: '',
              future: _location.street,
              builder: (_, ss) => Text(
                'street: ${ss.data}' ?? '',
                style: TextStyles.textWhite14,
              ),
            ),
          if (_location != null)
            FutureBuilder<String>(
              initialData: '',
              future: _location.aoiName,
              builder: (_, ss) => Text(
                'aoiName: ${ss.data}' ?? '',
                style: TextStyles.textWhite14,
              ),
            ),
          if (_location != null)
            FutureBuilder<double>(
              initialData: 0.0,
              future: _location.latLng.then((it) => it.latitude),
              builder: (_, ss) => Text(
                'latitude: ${ss.data}' ?? '',
                style: TextStyles.textWhite14,
              ),
            ),
          if (_location != null)
            FutureBuilder<double>(
              initialData: 0.0,
              future: _location.latLng.then((it) => it.longitude),
              builder: (_, ss) => Text(
                'longitude: ${ss.data}' ?? '',
                style: TextStyles.textWhite14,
              ),
            ),
          if (_location != null)
            FutureBuilder<double>(
              initialData: 0.0,
              future: _location.altitude,
              builder: (_, ss) => Text(
                'altitude: ${ss.data}' ?? '',
                style: TextStyles.textWhite14,
              ),
            ),
          if (_location != null)
            FutureBuilder<double>(
              initialData: 0.0,
              future: _location.bearing,
              builder: (_, ss) => Text(
                'bearing: ${ss.data}' ?? '',
                style: TextStyles.textWhite14,
              ),
            ),
          if (_location != null)
            FutureBuilder<double>(
              initialData: 0.0,
              future: _location.accuracy,
              builder: (_, ss) => Text(
                'accuracy: ${ss.data}' ?? '',
                style: TextStyles.textWhite14,
              ),
            ),
        ],
      ),
    );
  }
}
