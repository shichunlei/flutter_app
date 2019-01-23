import 'package:flutter/material.dart';

const List<String> _defaultActions = <String>[
  'Flutter',
  'Android',
  'iOS',
  'Java',
  'Object-C',
  'JavaScript',
  'Ruby',
  'PHP',
  'C++',
  'C#',
  'C语言',
  'Dart',
  'Kotlin',
  'Swift'
];

class ChipWidget extends StatefulWidget {
  @override
  _ChipWidgetState createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  String _selectedMaterial = '';

  List<String> _actions = [];

  @override
  void initState() {
    super.initState();
    _actions.addAll(_defaultActions);
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
            Wrap(
              spacing: 10.0,
              children: _buildChipItem(removeItem()),
            ),
            Wrap(
              spacing: 10.0,
              children: _buildChoiceChipItem(_defaultActions),
            ),
            Wrap(
              spacing: 10.0,
              children: _buildAvatarChipItem(_defaultActions),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildChipItem(List<String> _defaultActions) {
    List<Widget> widgets = [];
    for (var i = 0; i < _defaultActions.length; i++) {
      widgets.add(
        Chip(
          backgroundColor: _nameToColor(_defaultActions[i]),
          label: Text(_defaultActions[i].toString(),
              style: TextStyle(color: Colors.white)),
          onDeleted: () {
            setState(() {
              removeItem(value: _defaultActions[i].toString());
            });
          },
        ),
      );
    }

    return widgets;
  }

  List<Widget> _buildChoiceChipItem(List<String> _defaultActions) {
    List<Widget> widgets = [];
    for (var i = 0; i < _defaultActions.length; i++) {
      widgets.add(
        ChoiceChip(
          selected: _selectedMaterial == _defaultActions[i],
          backgroundColor: _nameToColor(_defaultActions[i]),
          label: Text(_defaultActions[i].toString(),
              style: TextStyle(color: Colors.white)),
          avatar:
              _selectedMaterial == _defaultActions[i] ? Icon(Icons.done) : null,
          selectedColor: Colors.redAccent,
          onSelected: (bool isCheck) {
            setState(() {
              _selectedMaterial = isCheck ? _defaultActions[i] : "";
            });
          },
        ),
      );
    }

    return widgets;
  }

  List<Widget> _buildAvatarChipItem(List<String> _defaultActions) {
    List<Widget> widgets = [];
    for (var i = 0; i < _defaultActions.length; i++) {
      widgets.add(
        Chip(
            backgroundColor: _nameToColor(_defaultActions[i]),
            label: Text(_defaultActions[i].toString(),
                style: TextStyle(color: Colors.white)),
            avatar: CircleAvatar(
              backgroundImage: NetworkImage(
                "http://i1.umei.cc/uploads/tu/201901/9999/rn71dec568c9.jpg",
              ),
            )),
      );
    }

    return widgets;
  }

  Color _nameToColor(String name) {
    assert(name.length > 1);
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  List<String> removeItem({String value = ""}) {
    _actions.remove(value);
    return _actions;
  }
}
