import 'package:flutter/material.dart';

class ItemTag extends StatelessWidget {
  final String tag;

  ItemTag({Key key, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
        label: Text(tag, style: TextStyle(color: Colors.white)),
        backgroundColor: _nameToColor(tag));
  }

  Color _nameToColor(String name) {
    assert(name.length > 1);
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }
}
