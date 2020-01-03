import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/page_index.dart';
import '../index.dart';

class BuildPhoneView extends StatefulWidget {
  final String phone;
  final String cell;

  BuildPhoneView({Key key, this.phone, this.cell}) : super(key: key);

  @override
  _BuildPhoneViewState createState() => _BuildPhoneViewState();
}

class _BuildPhoneViewState extends State<BuildPhoneView> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: ContactCategory(
        icon: Icons.call,
        children: <Widget>[
          ContactItem(
            icon: Icons.call,
            tooltip: "call",
            onPressed: () {
              Utils.launchURL('tel:${widget.phone}');
            },
            lines: <String>[
              '${widget.phone}',
              'Mobile',
            ],
          ),
          ContactItem(
            icon: Icons.message,
            tooltip: "send message",
            onPressed: () {
              Utils.launchURL('sms:${widget.phone}');
            },
            lines: <String>[
              '${widget.cell}',
              'Work',
            ],
          ),
//          ContactItem(
//            icon: Icons.message,
//            tooltip: "send message",
//            onPressed: () {},
//            lines: const <String>[
//              '18510634252',
//              'Home',
//            ],
//          ),
        ],
      ),
    );
  }
}
