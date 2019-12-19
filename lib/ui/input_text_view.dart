import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/res/styles.dart';

class InputTextPage extends StatefulWidget {
  InputTextPage({
    Key key,
    @required this.title,
    this.content,
    this.hintText,
    this.keyboardType: TextInputType.text,
    this.maxLength: 30,
    this.maxLines: 5,
  }) : super(key: key);

  final String title;
  final String content;
  final String hintText;
  final TextInputType keyboardType;

  final int maxLength;
  final int maxLines;

  @override
  createState() => _InputTextPageState();
}

class _InputTextPageState extends State<InputTextPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: Text(S.of(context).complete),
              onPressed: () {
                Navigator.of(context).pop(_controller.text);
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 21.0, left: 16.0, right: 16.0, bottom: 16.0),
        child: TextField(
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          autofocus: true,
          controller: _controller,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              hintStyle: TextStyles.textGreyC14),
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ),
    );
  }
}
