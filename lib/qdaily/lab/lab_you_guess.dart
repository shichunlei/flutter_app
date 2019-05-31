import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/qdaily/ui/bottom_appbar.dart';

/// 你猜/你谁啊/
class LabYouGuessPage extends StatefulWidget {
  final int id;

  LabYouGuessPage({Key key, @required this.id}) : super(key: key);

  @override
  createState() => _LabYouGuessPageState();
}

class _LabYouGuessPageState extends State<LabYouGuessPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: <Widget>[
          Expanded(child: Center()),
          BottomAppbar(actions: <Widget>[])
        ],
      ),
    );
  }
}
