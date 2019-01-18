import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final IconData icon;
  final List<String> lines;
  final String tooltip;
  final VoidCallback onPressed;

  ContactItem({Key key, this.icon, this.lines, this.tooltip, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final List<Widget> columnChildren = lines
        .sublist(
          0,
          lines.length - 1,
        )
        .map<Widget>((String line) => Text(line))
        .toList();
    columnChildren.add(
      Text(
        lines.last,
        style: themeData.textTheme.caption,
      ),
    );

    final List<Widget> rowChildren = <Widget>[
      Expanded(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columnChildren),
      ),
    ];
    if (icon != null) {
      rowChildren.add(
        SizedBox(
          width: 72.0,
          child: IconButton(
              icon: Icon(icon),
              color: themeData.primaryColor,
              onPressed: onPressed),
        ),
      );
    }

    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rowChildren),
      ),
    );
  }
}
