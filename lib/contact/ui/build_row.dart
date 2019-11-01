import 'dart:async';

import 'package:flutter/material.dart';
import '../../page_index.dart';
import '../index.dart';
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
        StreamBuilder<bool>(
            stream: _streamController.stream, //数据流
            initialData: false, //初始值
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              isFavorite = snapshot.data;
              return ContactImageText(
                icon: Icon(
                    snapshot.data ? Icons.favorite : Icons.favorite_border,
                    color: snapshot.data ? Colors.redAccent : Colors.grey),
                text: Text(snapshot.data
                    ? "${S.of(context).cancel_collect}"
                    : "${S.of(context).collect}"),
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
