import 'package:flutter/material.dart';
import 'package:flutter_app/bean/photos.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemPhoto extends StatelessWidget {
  final VoidCallback onTap;
  final Photos photo;

  ItemPhoto(this.photo, {Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              /// 圆角
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
              ),
              child: Hero(
                tag: photo.id,
                child: FadeInImage(
                  placeholder: AssetImage("images/wallfy.png"),
                  image: NetworkImage(photo.cover),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(photo.author.avatar),
                  ),
                ),
                Text(photo.author.name),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
