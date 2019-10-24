import 'package:flutter/material.dart';
import 'package:flutter_jd_address_selector/flutter_jd_address_selector.dart';

import '../generated/i18n.dart';
import '../store/index.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
          body: ListView(padding: EdgeInsets.zero, children: <Widget>[
            ListTile(
                onTap: () => _openLanguageSelectMenu(),
                leading: Icon(Icons.language),
                title: Text(S.of(context).language),
                trailing: Container(
                  child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Text(
                      '${mapSupportLocale[SupportLocale.values[value.localIndex]]}',
                      style: Theme.of(context).textTheme.caption,
                    ),
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
                  child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Expanded(
                        child: Text(
                      '${address ?? S.of(context).choose}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.caption,
                    )),
                    Icon(Icons.navigate_next)
                  ]),
                )),
            Line(
              color: Colors.grey,
              lineHeight: 10,
            ),
            ExpansionTile(
              leading: Icon(Icons.language),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(S.of(context).language),
                  Text(
                    '${mapSupportLocale[SupportLocale.values[value.localIndex]]}',
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
              children: _items2(),
            ),
            Gaps.line,
            ExpansionTile(
              leading: Icon(Icons.color_lens),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(S.of(context).theme),
                  Container(color: Color(value.theme), height: 15, width: 15)
                ],
              ),
              children: _itemColors(),
            ),
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

  List<Widget> _items2() {
    return SupportLocale.values.map((local) {
      int index = SupportLocale.values.indexOf(local);
      return RadioListTile(
        value: index,
        title: Text("${mapSupportLocale[local]}"),
        onChanged: (index) {
          Store.value<ConfigModel>(context).setLocal(index);
          //Navigator.pop(context);
        },
        groupValue: Store.value<ConfigModel>(context).localIndex,
      );
    }).toList();
  }

  List<Widget> _itemColors() {
    List<Widget> _colors = [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Wrap(spacing: 5, runSpacing: 5, children: <Widget>[
            ...Colors.primaries.map((color) {
              return Material(
                color: color,
                child: InkWell(
                  onTap: () =>
                      Store.value<ConfigModel>(context).setTheme(color.value),
                  child: Container(
                    width: 40,
                    height: 40,
                    child:
                        Store.value<ConfigModel>(context).theme == color.value
                            ? Icon(Icons.done)
                            : SizedBox(),
                  ),
                ),
              );
            }).toList(),
            Material(
              child: InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).accentColor)),
                  width: 40,
                  height: 40,
                  child: Text(
                    "?",
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).accentColor),
                  ),
                ),
              ),
            )
          ]))
    ];
    return _colors;
  }
}
