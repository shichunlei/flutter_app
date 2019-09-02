import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class LikeButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LikeButton'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            LikeButton(
              width: 80.0,
            ),
            LikeButton(
              width: 80.0,
              circleStartColor: Color(0xff00ddff),
              circleEndColor: Color(0xff0099cc),
              dotColor: DotColor(
                dotPrimaryColor: Color(0xff33b5e5),
                dotSecondaryColor: Color(0xff0099cc),
              ),
              icon: LikeIcon(
                Icons.home,
                iconColor: Colors.deepPurpleAccent,
              ),
            ),
            LikeButton(
              width: 80.0,
              duration: Duration(milliseconds: 500),
              circleStartColor: Color(0xff669900),
              circleEndColor: Color(0xff669900),
              dotColor: DotColor(
                dotPrimaryColor: Color(0xff669900),
                dotSecondaryColor: Color(0xff99cc00),
              ),
              icon: LikeIcon(
                Icons.adb,
                iconColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
