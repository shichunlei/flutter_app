import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool status;

  CustomButton({Key key, this.onPressed, this.title, this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      shape: const StadiumBorder(),
      color: status ? Colors.white : Color(0x002B2B2B),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16.0, color: status ? Color(0xFF2B2B2B) : Colors.white),
      ),
    );
  }
}
