import 'package:custom_widgets/titled_navigation_bar.dart';
import 'package:flutter/material.dart';

class TitledNavigationBarDemo extends StatefulWidget {
  TitledNavigationBarDemo({Key key}) : super(key: key);

  @override
  createState() => _TitledNavigationBarDemoState();
}

class _TitledNavigationBarDemoState extends State<TitledNavigationBarDemo> {
  final List<TitledNavigationBarItem> items = [
    TitledNavigationBarItem(title: 'Home', icon: Icons.home),
    TitledNavigationBarItem(title: 'Search', icon: Icons.search),
    TitledNavigationBarItem(title: 'Bag', icon: Icons.card_travel),
    TitledNavigationBarItem(title: 'Orders', icon: Icons.shopping_cart),
    TitledNavigationBarItem(title: 'Profile', icon: Icons.person_outline),
  ];

  bool navBarMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Titled Bottom Bar"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Reversed mode:"),
            Switch(
              value: navBarMode,
              onChanged: (v) {
                setState(() => navBarMode = v);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: TitledBottomNavigationBar(
        onTap: (index) => print("Selected Index: $index"),
        reverse: navBarMode,
        curve: Curves.easeInBack,
        items: items,
        activeColor: Colors.red,
        inactiveColor: Colors.blueGrey,
      ),
    );
  }
}
