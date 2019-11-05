import 'package:flutter/material.dart';

class CTextField extends StatelessWidget {
  CTextField({this.controller, this.hintText, this.obscure: false, this.icon});

  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.yellow[900]),
          SizedBox(width: width / 30),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              decoration: InputDecoration.collapsed(
                hintText: hintText,
              ),
            ),
          ),
        ],
      ),
      padding: EdgeInsets.only(bottom: 4.0),
      margin: EdgeInsets.only(
          top: height / 40, right: width / 20, left: width / 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.yellow[900]),
        ),
      ),
    );
  }
}
