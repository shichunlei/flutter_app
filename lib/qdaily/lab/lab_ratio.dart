import 'package:flutter/material.dart';
import '../ui/bottom_appbar.dart';

/// 42%
class LabRatioPage extends StatefulWidget {
  final int id;

  LabRatioPage({Key key, @required this.id}) : super(key: key);

  @override
  createState() => _LabRatioPageState();
}

class _LabRatioPageState extends State<LabRatioPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
