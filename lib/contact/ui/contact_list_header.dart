import 'package:flutter/material.dart';

class ContactListHeader extends StatelessWidget {
  final String name;
  final String phone;

  ContactListHeader({
    Key key,
    this.name,
    this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: Image.network(
                'https://github.com/huextrat/TheGorgeousLogin/blob/master/assets/img/login_logo.png?raw=true',
                width: 80.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                this.name,
                textScaleFactor: 1.2,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              this.phone,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
