import 'package:flutter/material.dart';

class ValueListenableBuilderWidget extends StatelessWidget {
  ValueListenableBuilderWidget({Key key}) : super(key: key);

  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('ValueListenableBuilder')),
      body: Center(
        child: ValueListenableBuilder(
          builder: (BuildContext context, int value, Widget child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_box),
                  onPressed: () => _counter.value += 1,
                ),
                Text('$value'),
                IconButton(
                  icon: Icon(Icons.indeterminate_check_box),
                  onPressed: () => _counter.value -= 1,
                ),
              ],
            );
          },
          valueListenable: _counter,
        ),
      ),
    );
  }
}
