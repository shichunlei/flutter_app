import 'package:flutter/material.dart';

class ThirdLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  ThirdLoginButton({Key key, this.onPressed, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: IconButton(
          icon: Icon(icon), color: Color(0xFF0084ff), onPressed: onPressed),
    );
  }
}
