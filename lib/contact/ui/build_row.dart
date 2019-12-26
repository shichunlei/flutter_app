import 'dart:async';

import 'package:flutter/material.dart';
import '../../page_index.dart';
import 'package:flutter_app/generated/i18n.dart';

class BuildRowView extends StatefulWidget {
  @override
  createState() => _BuildRowViewState();
}

class _BuildRowViewState extends State<BuildRowView> {
  bool isFavorite = false;

  StreamController<bool> _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<bool>.broadcast();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconText(
          icon: Icon(
            Icons.share,
            color: Colors.grey,
          ),
          text: "${S.of(context).share}",
          onPressed: () {},
        ),
        LineWidget(
          height: 34.0,
          width: 1.0,
          lineType: LineType.vertical,
        ),
        IconText(
          icon: Icon(
            Icons.history,
            color: Colors.grey,
          ),
          text: "${S.of(context).call_history}",
          onPressed: () {},
        ),
        LineWidget(
          height: 34.0,
          width: 1.0,
          lineType: LineType.vertical,
        ),
        StreamBuilder<bool>(
            stream: _streamController.stream, //数据流
            initialData: false, //初始值
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              isFavorite = snapshot.data;
              return IconText(
                icon: Icon(
                    snapshot.data ? Icons.favorite : Icons.favorite_border,
                    color: snapshot.data ? Colors.redAccent : Colors.grey),
                text: snapshot.data
                    ? "${S.of(context).cancel_collect}"
                    : "${S.of(context).collect}",
                onPressed: () => _toggleFavorite(),
              );
            }),
      ],
    );
  }

  void _toggleFavorite() async {
    _streamController.sink.add(!isFavorite);
  }
}
