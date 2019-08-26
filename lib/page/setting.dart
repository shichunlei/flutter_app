import 'package:flutter/material.dart';

import '../generated/i18n.dart';
import '../store/index.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_jd_address_selector/flutter_jd_address_selector.dart';

import '../page_index.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Color _pickerColor;

  String address;

  @override
  Widget build(BuildContext context) {
    return Store.connect<ConfigModel>(
        builder: (BuildContext context, ConfigModel value, Widget child) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: Text(S.of(context).setting)),
          body: ListView(padding: EdgeInsets.all(10), children: <Widget>[
            ListTile(
                onTap: () => _openLanguageSelectMenu(),
                leading: Icon(Icons.language),
                title: Text(S.of(context).language),
                trailing: Container(
                  child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Text(
                        '${mapSupportLocale[SupportLocale.values[value.localIndex]]}'),
                    Icon(Icons.navigate_next)
                  ]),
                )),
            Gaps.line,
            ListTile(
                onTap: () => _chooseColor(),
                leading: Icon(Icons.color_lens),
                title: Text(S.of(context).theme),
                trailing: Container(
                  child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Container(color: Color(value.theme), height: 15, width: 15),
                    Icon(Icons.navigate_next)
                  ]),
                )),
            Gaps.line,
            ListTile(
                onTap: () => _chooseAddress(),
                leading: Icon(Icons.location_on),
                title: Text(S.of(context).choice_address),
                trailing: Container(
                    width: 160.0,
                    child:
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Expanded(
                          child: Text('${address ?? S.of(context).choose}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.right)),
                      Icon(Icons.navigate_next)
                    ]))),
            Gaps.line
          ]));
    });
  }

  /// 国际化
  void _openLanguageSelectMenu() async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) => Container(
              child: Column(mainAxisSize: MainAxisSize.min, children: _items()),
            ));
  }

  void _chooseColor() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
                title: Text(S.of(context).pick_a_color),
                content: SingleChildScrollView(
                    child: ColorPicker(
                        pickerColor:
                            Color(Store.value<ConfigModel>(context).theme),
                        onColorChanged: (color) =>
                            setState(() => _pickerColor = color),
                        enableLabel: true,
                        pickerAreaHeightPercent: 0.8)),
                actions: <Widget>[
                  FlatButton(
                      child: Text(S.of(context).sure),
                      onPressed: () {
                        if (_pickerColor != null) {
                          Store.value<ConfigModel>(context)
                              .setTheme(_pickerColor.value);
                        }
                        Navigator.of(context).pop();
                      })
                ]));
  }

  void _chooseAddress() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return JDAddressDialog(
              onSelected: (province, city, county) {
                setState(() {
                  address = '$province$city$county';
                  Toast.show(context, '$province-$city-$county');
                });
              },
              title: '${S.of(context).choice_address}');
        });
  }

  List<Widget> _items() {
    return SupportLocale.values.map((local) {
      int index = SupportLocale.values.indexOf(local);
      return ListTile(
          title: Text("${mapSupportLocale[local]}"),
          onTap: () {
            Store.value<ConfigModel>(context).setLocal(index);
            Navigator.pop(context);
          },
          selected: Store.value<ConfigModel>(context).localIndex == index);
    }).toList();
  }
}
