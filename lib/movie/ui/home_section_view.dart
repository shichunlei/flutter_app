import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeSectionView extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String more;
  final bool hiddenMore;

  HomeSectionView(
    this.title, {
    Key key,
    this.onPressed,
    this.more = "更多",
    this.hiddenMore = false,
  })  : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(15, 15, 5, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "$title",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 5),
              Container(
                  width: title.length * 20.0, height: 2, color: Colors.black),
            ],
          ),
          Offstage(
            child: FlatButton(
              color: Colors.white,
              onPressed: onPressed,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$more',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(width: 3),
                  Icon(CupertinoIcons.forward, size: 14),
                ],
              ),
            ),
            offstage: hiddenMore,
          ),
        ],
      ),
    );
  }
}
