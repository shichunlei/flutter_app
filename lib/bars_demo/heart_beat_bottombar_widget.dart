import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/heart_beat_bottombar/heart_beat_bottombar.dart';

class HeartBeatBottomBarWidget extends StatefulWidget {
  HeartBeatBottomBarWidget({Key key}) : super(key: key);

  @override
  createState() => _HeartBeatBottomBarWidgetState();
}

class _HeartBeatBottomBarWidgetState extends State<HeartBeatBottomBarWidget> {
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
      body: null,
      bottomNavigationBar: HeartBeatBottomBar(),
    );
  }
}
