import 'package:flutter/material.dart';
import '../index.dart';
import 'package:flutter_app/generated/i18n.dart';

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
    String favoriteText = "${S.of(context).collect}";

    void _toggleFavorite() {
      setState(() {
        if (isFavorite) {
          isFavorite = false;
          favoriteIcon = Icons.favorite_border;
          favoriteColor = Colors.grey;
          favoriteText = "${S.of(context).collect}";
        } else {
          isFavorite = true;
          favoriteIcon = Icons.favorite;
          favoriteColor = Colors.redAccent;
          favoriteText = "${S.of(context).cancel_collect}";
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
          text: Text("${S.of(context).share}"),
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
          text: Text("${S.of(context).call_history}"),
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
