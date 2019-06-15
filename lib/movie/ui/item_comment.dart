import 'package:flutter/material.dart';
import 'package:flutter_app/bean/reviews.dart';
import 'package:flutter_app/custom_widgets/smooth_star_rating.dart';

class ItemComment extends StatelessWidget {
  final Reviews comment;
  final Color background;

  const ItemComment({
    Key key,
    this.comment,
    this.background = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(comment.author.avatar),
                radius: 16.0,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    comment.author.name,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: <Widget>[
                      SmoothStarRating(
                        rating: comment.rating.value == 0
                            ? 0.0
                            : comment.rating.value,
                        size: 20,
                        allowHalfRating: false,
                      ),
                      SizedBox(width: 10),
                      Text(
                        comment.created_at,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            comment.content,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          SizedBox(height: 8),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                color: Colors.white,
                size: 12,
              ),
              SizedBox(width: 5),
              Text(
                '${comment.useful_count}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
