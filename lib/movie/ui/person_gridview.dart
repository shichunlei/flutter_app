import 'package:flutter/material.dart';

import 'package:flutter_app/movie/bean/casts.dart';
import 'package:flutter_app/utils/utils.dart';

class PersonGridView extends StatelessWidget {
  final Casts casts;
  final Color textColor;
  final VoidCallback onTap;

  PersonGridView({
    Key key,
    this.casts,
    this.textColor = Colors.grey,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = (Utils.width - 6 * 3 - 5 * 3) / 4;

    return Container(
      width: width,
      child: Column(
        children: <Widget>[
          GestureDetector(
            //点击事件
            onTap: onTap,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                casts.avatars.small.toString(),
              ),
              radius: 40.0,
            ),
          ),
          Text(
            casts.name,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}
