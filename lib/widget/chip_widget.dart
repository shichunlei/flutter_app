import 'package:flutter/material.dart';

import '../page_index.dart';

class ChipWidget extends StatefulWidget {
  @override
  createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  String _selectedMaterial = '';

  List<String> _actions = [];

  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _actions.addAll(languages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chip Widget'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Text('Chip'),
            Wrap(
              /// 主轴方向上的间距
              spacing: 10.0,
              children: removeItem()
                  .map((language) => Chip(
                        backgroundColor: Utils.strToColor(language),
                        label: Text(language.toString(),
                            style: TextStyle(color: Colors.white)),
                        onDeleted: () {
                          setState(() {
                            removeItem(value: language.toString());
                          });
                        },
                      ))
                  .toList(),
            ),
            Text('ChoiceChip'),
            Wrap(
              spacing: 10.0,
              children: languages
                  .map((language) => ChoiceChip(
                        selected: _selectedMaterial == language,
                        backgroundColor: Utils.strToColor(language),
                        label: Text(language.toString(),
                            style: TextStyle(color: Colors.white)),
                        avatar: _selectedMaterial == language
                            ? Icon(Icons.done)
                            : null,
                        selectedColor: Utils.strToColor(language),
                        onSelected: (bool isCheck) {
                          setState(() {
                            _selectedMaterial = isCheck ? language : "";
                          });
                        },
                      ))
                  .toList(),
            ),
            Text('InputChip'),
            Wrap(
              spacing: 10.0,
              children: languages
                  .map((language) => InputChip(
                      label: Text(language.toString(),
                          style: TextStyle(color: Colors.white)),
                      avatar: ImageLoadView(
                          'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1408166520,3304498136&fm=26&gp=0.jpg',
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      onPressed: () {},
                      backgroundColor: Utils.strToColor(language)))
                  .toList(),
            ),
            Text('FilterChip'),
            Wrap(
              spacing: 10.0,
              children: languages
                  .map((language) => FilterChip(
                      backgroundColor: Utils.strToColor(language),
                      label: Text(language),
                      selected: _isSelected,
                      onSelected: (isSelected) {
                        setState(() {
                          _isSelected = isSelected;
                        });
                      },
                      selectedColor: Utils.strToColor(language)))
                  .toList(),
            ),
            Text('ActionChip'),
            Wrap(
              spacing: 10.0,
              children: languages
                  .map((language) => ActionChip(
                        backgroundColor: Utils.strToColor(language),
                        label: Text(language),
                        onPressed: () {
                          Toast.show(context, language);
                        },
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  List<String> removeItem({String value = ""}) {
    _actions.remove(value);
    return _actions;
  }
}
