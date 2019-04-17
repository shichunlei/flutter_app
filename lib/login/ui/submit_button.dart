import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  SubmitButton({Key key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(
            left: 50.0, right: 50.0, top: 10.0, bottom: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            gradient: const LinearGradient(
              colors: const [const Color(0xFFfbab66), const Color(0xFFf7418c)],
              stops: const [0.0, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
        child: Text(
          title,
          style: TextStyle(fontSize: 22.0, color: Colors.white),
        ),
      ),
      onTap: onTap,
    );
  }
}
