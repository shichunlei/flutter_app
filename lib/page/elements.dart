import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/bean/element.dart';

import '../page_index.dart';

const kRowCount = 10;

const kContentSize = 74.0;
const kGutterWidth = 2.0;

const kGutterInset = EdgeInsets.all(kGutterWidth);

class ElementsPage extends StatelessWidget {
  ElementsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
            title: Text('元素周期表'),
            centerTitle: true,
            backgroundColor: Colors.blueGrey[800]),
        body: FutureBuilder<List<ElementData>>(
          future: fetchData(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ElementData>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.active:
              case ConnectionState.waiting:
                return LoadingView();
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return ErrorPage(text: '数据加载失败');
                } else {
                  return _buildTable(snapshot.data);
                }
                break;
            }
            return null;
          },
        ));
  }

  Future<List<ElementData>> fetchData() async {
    List<ElementData> _gridList =
        await rootBundle.loadString('assets/data/elements.json').then((value) {
      debugPrint('$value');
      return ElementData.fromMapList(json.decode(value));
    });

    return _gridList;
  }

  Widget _buildTable(List<ElementData> list) {
    final tiles = list
        .map((element) => element != null
            ? ElementTile(element)
            : Container(color: Colors.black38, margin: kGutterInset))
        .toList();

    return SingleChildScrollView(
      child: SizedBox(
        height: kRowCount * (kContentSize + (kGutterWidth * 2)),
        child: GridView.count(
          crossAxisCount: kRowCount,
          children: tiles,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

class ElementTile extends StatelessWidget implements PreferredSizeWidget {
  const ElementTile(this.element, {this.isLarge = false});

  final ElementData element;
  final bool isLarge;

  Size get preferredSize => Size.fromHeight(kContentSize * 1.5);

  @override
  Widget build(BuildContext context) {
    final tileText = <Widget>[
      Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text('${element.number}',
              style: TextStyle(fontSize: 10.0, color: Colors.white))),
      Text(element.symbol, style: Theme.of(context).primaryTextTheme.headline5),
      Text(element.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: isLarge ? 0.65 : 1,
          style: Theme.of(context).primaryTextTheme.bodyText2)
    ];

    final tile = Container(
      margin: kGutterInset,
      width: kContentSize,
      height: kContentSize,
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(colors: element.colors),
        backgroundBlendMode: BlendMode.multiply,
      ),
      child: RawMaterialButton(
        onPressed: !isLarge
            ? () => pushNewPage(context, ElementDetailsPage(element: element))
            : null,
        fillColor: Colors.grey[800],
        disabledElevation: 10.0,
        padding: kGutterInset * 2.0,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: tileText),
      ),
    );

    return Hero(
      tag: 'hero-${element.symbol}',
      flightShuttleBuilder: (_, anim, __, ___, ____) => ScaleTransition(
          scale: anim.drive(Tween(begin: 1, end: 1.75)), child: tile),
      child: Transform.scale(scale: isLarge ? 1.75 : 1, child: tile),
    );
  }
}

class ElementDetailsPage extends StatelessWidget {
  final ElementData element;

  ElementDetailsPage({Key key, this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listItems = <Widget>[
      ListTile(
          leading: Icon(Icons.category, color: Colors.white),
          title: Text(
            element.category.toUpperCase(),
            style: TextStyles.textWhite14,
          )),
      ListTile(
        leading: Icon(Icons.info, color: Colors.white),
        title: Text(
          element.extract,
          style: TextStyles.textWhite16,
        ),
        subtitle: Text(element.source, style: TextStyles.textWhite14),
      ),
      ListTile(
        leading: Icon(
          Icons.fiber_smart_record,
          color: Colors.white,
        ),
        title: Text(
          element.atomicWeight,
          style: TextStyles.textWhite16,
        ),
        subtitle: Text('Atomic Weight', style: TextStyles.textWhite14),
      ),
    ].expand((widget) => [widget, Divider()]).toList();

    return Scaffold(
      backgroundColor:
          Color.lerp(Colors.grey[850], element?.colors?.first, 0.07),
      appBar: AppBar(
        backgroundColor:
            Color.lerp(Colors.grey[850], element?.colors?.elementAt(1), 0.2),
        bottom: ElementTile(element, isLarge: true),
      ),
      body: ListView(
          padding: EdgeInsets.only(top: 24.0, bottom: 24.0),
          children: listItems),
    );
  }
}
