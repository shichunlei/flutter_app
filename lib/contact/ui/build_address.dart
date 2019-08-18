import 'package:flutter/material.dart';

import '../index.dart';

class BuildAddressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContactCategory(
      icon: Icons.location_on,
      children: <Widget>[
        ContactItem(
          icon: Icons.map,
          tooltip: 'Open map',
          onPressed: () {},
          lines: const <String>[
            '中国北京市海淀区',
            '四季青镇龚村173号',
            'Home',
          ],
        ),
        ContactItem(
          icon: Icons.map,
          tooltip: 'Open map',
          onPressed: () {},
          lines: const <String>[
            '中国北京市海淀区',
            '中关村梦想实验室8层806室',
            'Work',
          ],
        ),
        ContactItem(
          icon: Icons.map,
          tooltip: 'Open map',
          onPressed: () {},
          lines: const <String>[
            '中国河北省衡水市',
            '阜城县漫河乡前宣屯村',
            'Jet Travel',
          ],
        ),
      ],
    );
  }
}
