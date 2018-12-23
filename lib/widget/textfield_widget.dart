import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  @override
  createState() => TextFieldWidgetState();
}

class TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Button Widget"),
      ),
      body: new Column(
        children: builderTextField(),
      ),
    );
  }

  List<Widget> builderTextField() {
    return null;
  }
}
