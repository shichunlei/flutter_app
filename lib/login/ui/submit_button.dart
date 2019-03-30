import 'package:flutter/material.dart';
import 'package:flutter_app/utils/theme.dart' as theme;

class SubmitButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  SubmitButton({Key key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.only(
            left: 50.0, right: 50.0, top: 10.0, bottom: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            gradient: theme.Theme.primaryGradient),
        child: Text(
          title,
          style: TextStyle(fontSize: 22.0, color: Colors.white),
        ),
      ),
      onTap: onTap,
    );
  }
}
