import 'package:flutter/material.dart';

class ColorFilteredWidget extends StatefulWidget {
  ColorFilteredWidget({Key key}) : super(key: key);

  @override
  createState() => _ColorFilteredWidgetState();
}

class _ColorFilteredWidgetState extends State<ColorFilteredWidget> {
  var mode = BlendMode.dst;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(Colors.red, mode),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('ColorFiltered')),
        body: Center(
          child: ListView(
            children: (List.from(BlendMode.values)
                  ..sort((a, b) => a.toString().compareTo(b.toString())))
                .map(
                  (m) => ListTile(
                    title: Text(m.toString()),
                    selected: m == mode,
                    onTap: () => setState(() => mode = m),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
