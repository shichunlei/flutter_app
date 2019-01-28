import 'package:flutter/material.dart';

class ContactListHeader extends StatelessWidget {
  final String name;
  final String phone;

  ContactListHeader({Key key, this.name, this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          ClipOval(child: Image.asset('images/flutter_logo.png', width: 80.0)),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(this.name,
                  textScaleFactor: 1.2, style: TextStyle(fontSize: 20.0))),
          Text(this.phone, style: TextStyle(fontSize: 20.0))
        ]));
  }
}
