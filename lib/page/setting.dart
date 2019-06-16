import 'package:flutter/material.dart';
import 'package:flutter_app/lang/index.dart';
import 'package:flutter_app/store/index.dart';
import 'package:flutter_app/store/models/config_state_model.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_jd_address_selector/flutter_jd_address_selector.dart';

import '../page_index.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Color pickerColor;

  String address = '请选择';

  @override
  void initState() {
    super.initState();
    pickerColor = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text(AppLocalizations.$t('setting'))),
        body: ListView(padding: EdgeInsets.all(10), children: <Widget>[
          ListTile(
              onTap: () => _openLanguageSelectMenu(),
              leading: Icon(Icons.language),
              title: Text(AppLocalizations.$t('language')),
              trailing: Container(
                child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Text(AppLocalizations.$t('${AppLocalizations.languageCode}')),
                  Icon(Icons.navigate_next)
                ]),
              )),
          Gaps.line,
          ListTile(
              onTap: () => _chooseColor(),
              leading: Icon(Icons.color_lens),
              title: Text(AppLocalizations.$t('theme')),
              trailing: Container(
                child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Container(
                      color: Color(Store.value<ConfigModel>(context).theme),
                      height: 15,
                      width: 15),
                  Icon(Icons.navigate_next)
                ]),
              )),
          Gaps.line,
          ListTile(
              onTap: () => _chooseAddress(),
              leading: Icon(Icons.location_on),
              title: Text(AppLocalizations.$t('choice_address')),
              trailing: Container(
                  width: 160.0,
                  child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Expanded(
                        child: Text('$address',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.right)),
                    Icon(Icons.navigate_next)
                  ]))),
          Gaps.line
        ]));
  }

  /// 国际化
  void _openLanguageSelectMenu() async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) => Container(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                ListTile(
                    title: Text(AppLocalizations.$t('zh')),
                    onTap: () {
                      AppLocalizations.changeLanguage(Locale('zh'));
                      setState(() {});
                      Navigator.pop(context);
                    },
                    selected: AppLocalizations.languageCode == 'zh'),
                ListTile(
                    title: Text(AppLocalizations.$t('en')),
                    onTap: () {
                      AppLocalizations.changeLanguage(Locale('en'));
                      setState(() {});
                      Navigator.pop(context);
                    },
                    selected: AppLocalizations.languageCode == 'en')
              ]),
            ));
  }

  void _chooseColor() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
                title: Text(AppLocalizations.$t('pick_a_color')),
                content: SingleChildScrollView(
                    child: ColorPicker(
                        pickerColor:
                            Color(Store.value<ConfigModel>(context).theme),
                        onColorChanged: (color) =>
                            setState(() => pickerColor = color),
                        enableLabel: true,
                        pickerAreaHeightPercent: 0.8)),
                actions: <Widget>[
                  FlatButton(
                      child: Text(AppLocalizations.$t('sure')),
                      onPressed: () {
                        if (pickerColor != null) {
                          Store.value<ConfigModel>(context)
                              .$setTheme(pickerColor.value);
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
                  Toast.show('$province-$city-$county', context);
                });
              },
              title: '${AppLocalizations.$t('choice_address')}');
        });
  }
}
