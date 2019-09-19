import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../index.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildPhoneView extends StatefulWidget {
  final String phone;
  final String cell;
  Future<Null> launched;

  BuildPhoneView({Key key, this.phone, this.launched, this.cell})
      : super(key: key);

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
              setState(() {
                widget.launched = _launch('tel:${widget.phone}');
              });
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
              setState(() {
                widget.launched = _launch('sms:${widget.phone}');
              });
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

  Future<Null> _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
