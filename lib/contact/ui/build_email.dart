import 'package:flutter/material.dart';
import '../index.dart';

class BuildEmailView extends StatelessWidget {
  final String email;

  BuildEmailView({Key key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContactCategory(
      icon: Icons.contact_mail,
      children: <Widget>[
        ContactItem(
          icon: Icons.email,
          tooltip: "Send personal e-mail",
          onPressed: () {},
          lines: <String>[
            '$email',
            'Personal',
          ],
        ),
//        ContactItem(
//          icon: Icons.email,
//          tooltip: 'Send work e-mail',
//          onPressed: () {},
//          lines: <String>[
//            '$email',
//            'Work',
//          ],
//        ),
      ],
    );
  }
}
