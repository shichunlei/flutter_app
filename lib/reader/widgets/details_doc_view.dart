import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class DetailsDocView extends StatelessWidget {
  final List<DocsBean> docs;
  final String id;
  final VoidCallback onPressed;

  DetailsDocView(
      {Key key, @required this.docs, @required this.id, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: docsView(context),
        padding: EdgeInsets.only(top: 5, bottom: 0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false);
  }

  List<Widget> docsView(BuildContext context) {
    List<Widget> children = [];
    children
      ..add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: <Widget>[
            Text('热门短评', style: TextStyles.textDark16),
            InkWell(
                child: Row(children: <Widget>[
                  Icon(Icons.edit, color: readerMainColor, size: 15),
                  Text('写短评', style: TextStyles.textReader14)
                ], mainAxisSize: MainAxisSize.min),
                onTap: onPressed)
          ], mainAxisAlignment: MainAxisAlignment.spaceBetween)))
      ..add(ListView.separated(
          padding: EdgeInsets.only(top: 5),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          primary: false,
          itemBuilder: (_, index) => ItemDoc(doc: docs[index]),
          separatorBuilder: (_, index) => Line(
              margin: EdgeInsets.symmetric(horizontal: 20), color: Colors.grey),
          itemCount: docs.length))
      ..add(Line(
          margin: EdgeInsets.symmetric(horizontal: 20), color: Colors.grey))
      ..add(InkWell(
          child: Container(
              height: 50,
              child: Text('全部短评', style: TextStyles.textReader14),
              alignment: Alignment.center),
          onTap: docs.length == 0 ? null : () {}));

    return children;
  }
}
