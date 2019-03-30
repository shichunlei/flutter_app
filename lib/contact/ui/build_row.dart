import 'package:flutter/material.dart';
import 'package:flutter_app/contact/ui/contact_image_text.dart';
import 'package:flutter_app/contact/ui/line_widget.dart';

class BuildRowView extends StatefulWidget {
  @override
  _BuildRowViewState createState() => _BuildRowViewState();
}

class _BuildRowViewState extends State<BuildRowView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;
    IconData favoriteIcon = Icons.favorite_border;
    Color favoriteColor = Colors.grey;
    String favoriteText = "收藏";

    void _toggleFavorite() {
      setState(() {
        if (isFavorite) {
          isFavorite = false;
          favoriteIcon = Icons.favorite_border;
          favoriteColor = Colors.grey;
          favoriteText = "收藏";
        } else {
          isFavorite = true;
          favoriteIcon = Icons.favorite;
          favoriteColor = Colors.redAccent;
          favoriteText = "取消收藏";
        }
      });
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ContactImageText(
          icon: Icon(
            Icons.share,
            color: Colors.grey,
          ),
          text: Text("分享"),
          onPressed: () {},
        ),
        LineWidget(
          height: 34.0,
          width: 1.0,
          lineType: LineType.vertical,
        ),
        ContactImageText(
          icon: Icon(
            Icons.history,
            color: Colors.grey,
          ),
          text: Text("通话记录"),
          onPressed: () {},
        ),
        LineWidget(
          height: 34.0,
          width: 1.0,
          lineType: LineType.vertical,
        ),
        ContactImageText(
          icon: Icon(
            favoriteIcon,
            color: favoriteColor,
          ),
          text: Text(favoriteText),
          onPressed: () => _toggleFavorite(),
        ),
      ],
    );
  }
}
