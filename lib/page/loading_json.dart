import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class LoadingJsonPage extends StatefulWidget {
  LoadingJsonPage({Key key}) : super(key: key);

  @override
  _LoadingJsonPageState createState() => _LoadingJsonPageState();
}

class _LoadingJsonPageState extends State<LoadingJsonPage> {
  String txt = '';

  @override
  void initState() {
    super.initState();

    getJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Read Assets Json File'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('$txt'),
        ),
      ),
    );
  }

  void getJsonData() async {
    rootBundle.loadString('assets/data/contacts.json').then((value) {
      List list = json.decode(value);

      setState(() {
        txt = list.toString();
      });
    });
  }
}
