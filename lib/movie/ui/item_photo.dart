import 'package:flutter/material.dart';
import 'package:flutter_app/bean/photos.dart';
import 'package:flutter_app/ui/image_load_view.dart';

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
            Hero(
                tag: photo.id,
                child: ImageLoadView(photo.cover,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0)))),
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
