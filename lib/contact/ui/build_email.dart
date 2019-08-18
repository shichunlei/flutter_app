import 'package:flutter/material.dart';
import '../index.dart';

class BuildEmailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContactCategory(
      icon: Icons.contact_mail,
      children: <Widget>[
        ContactItem(
          icon: Icons.email,
          tooltip: "Send personal e-mail",
          onPressed: () {},
          lines: const <String>[
            '1558053958@qq.com',
            'Personal',
          ],
        ),
        ContactItem(
          icon: Icons.email,
          tooltip: 'Send work e-mail',
          onPressed: () {},
          lines: const <String>[
            'scl@chingsoft.com',
            'Work',
          ],
        ),
      ],
    );
  }
}
