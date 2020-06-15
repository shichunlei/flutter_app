import 'package:flutter/material.dart';
import '../index.dart';

class BuildOtherView extends StatelessWidget {
  final String birthday;

  BuildOtherView({this.birthday});

  @override
  Widget build(BuildContext context) {
    return ContactCategory(
      icon: Icons.today,
      children: <Widget>[
        ContactItem(
          lines: <String>[
            'Birthday',
            '$birthday',
          ],
        ),
        ContactItem(
          lines: const <String>[
            'Wedding anniversary',
            'June 21st, 2014',
          ],
        ),
        ContactItem(
          lines: const <String>[
            'First day in office',
            'January 20th, 2015',
          ],
        ),
        ContactItem(
          lines: const <String>[
            'Last day in office',
            'August 9th, 2018',
          ],
        ),
      ],
    );
  }
}
