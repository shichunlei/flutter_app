import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/toast/toast.dart';
import 'package:flutter_app/data.dart';

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
              children: _buildChipItem(removeItem()),
            ),
            Text('ChoiceChip'),
            Wrap(
              spacing: 10.0,
              children: _buildChoiceChipItem(languages),
            ),
            Text('InputChip'),
            Wrap(
              spacing: 10.0,
              children: _buildInputChipItem(languages),
            ),
            Text('FilterChip'),
            Wrap(
              spacing: 10.0,
              children: _buildFilterChipItem(languages),
            ),
            Text('ActionChip'),
            Wrap(
              spacing: 10.0,
              children: _buildActionChipItem(languages),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildChipItem(List<String> languages) {
    List<Widget> widgets = [];
    for (var i = 0; i < languages.length; i++) {
      widgets.add(
        Chip(
          backgroundColor: _nameToColor(languages[i]),
          label: Text(languages[i].toString(),
              style: TextStyle(color: Colors.white)),
          onDeleted: () {
            setState(() {
              removeItem(value: languages[i].toString());
            });
          },
        ),
      );
    }

    return widgets;
  }

  List<Widget> _buildChoiceChipItem(List<String> languages) {
    List<Widget> widgets = [];
    for (var i = 0; i < languages.length; i++) {
      widgets.add(
        ChoiceChip(
          selected: _selectedMaterial == languages[i],
          backgroundColor: _nameToColor(languages[i]),
          label: Text(languages[i].toString(),
              style: TextStyle(color: Colors.white)),
          avatar: _selectedMaterial == languages[i] ? Icon(Icons.done) : null,
          selectedColor: _nameToColor(languages[i]),
          onSelected: (bool isCheck) {
            setState(() {
              _selectedMaterial = isCheck ? languages[i] : "";
            });
          },
        ),
      );
    }

    return widgets;
  }

  bool _isSelected = false;

  List<Widget> _buildFilterChipItem(List<String> languages) {
    List<Widget> widgets = [];
    for (var i = 0; i < languages.length; i++) {
      widgets.add(FilterChip(
          backgroundColor: _nameToColor(languages[i]),
          label: Text(languages[i]),
          selected: _isSelected,
          onSelected: (isSelected) {
            setState(() {
              _isSelected = isSelected;
            });
          },
          selectedColor: _nameToColor(languages[i])));
    }

    return widgets;
  }

  List<Widget> _buildActionChipItem(List<String> languages) {
    List<Widget> widgets = [];
    for (var i = 0; i < languages.length; i++) {
      widgets.add(
        ActionChip(
          backgroundColor: _nameToColor(languages[i]),
          label: Text(languages[i]),
          onPressed: () {
            Toast.show(languages[i], context);
          },
        ),
      );
    }

    return widgets;
  }

  List<Widget> _buildInputChipItem(List<String> languages) {
    List<Widget> widgets = [];
    for (var i = 0; i < languages.length; i++) {
      widgets.add(
        InputChip(
          label: Text(languages[i].toString(),
              style: TextStyle(color: Colors.white)),
          avatar: CircleAvatar(
            backgroundColor: _nameToColor(languages[i]),
            backgroundImage: NetworkImage(
              "http://i1.umei.cc/uploads/tu/201901/9999/rn71dec568c9.jpg",
            ),
          ),
          onPressed: () {},
        ),
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
