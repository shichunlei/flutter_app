import 'package:flutter/material.dart';

class ContactImageText extends StatelessWidget {
  final Icon icon;
  final Text text;
  final VoidCallback onPressed;
  final double widthRate;

  ContactImageText(
      {Key key,
      @required this.icon,
      @required this.text,
      this.widthRate,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () => onPressed(),
        child: Container(
          padding: EdgeInsets.all(10.0),
          width: widthRate == null
              ? 80.0
              : MediaQuery.of(context).size.width * widthRate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: icon,
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
              Container(
                child: text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
