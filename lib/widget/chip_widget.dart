import 'package:flutter/material.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/global/data.dart';
import 'package:flutter_app/utils/utils.dart';

class ChipWidget extends StatefulWidget {
  @override
  _ChipWidgetState createState() => _ChipWidgetState();
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
                        avatar: CircleAvatar(
                          backgroundColor: Utils.strToColor(language),
                          backgroundImage: NetworkImage(
                            "http://i1.umei.cc/uploads/tu/201901/9999/rn71dec568c9.jpg",
                          ),
                        ),
                        onPressed: () {},
                      ))
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
                          Toast.show(language, context);
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
