import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';

class DetailsAppBarView extends StatelessWidget {
  final String title;

  DetailsAppBarView({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Store.connect<ReaderSettingModel>(builder:
        (BuildContext context, ReaderSettingModel snapshot, Widget child) {
      return AnimatedContainer(
          child: AppBar(
              leading: IconButton(
                  icon: Icon(Feather.chevron_left),
                  onPressed: () {
                    snapshot.hiddenSettingView();
                    Navigator.pop(context);
                  }),
              iconTheme: IconThemeData(color: Colors.white),
              brightness: snapshot.brightness,
              backgroundColor: Color(0xFA303030),
              title: Text('${title ?? ""}',
                  maxLines: 1, style: TextStyle(color: Colors.white))),
          height: snapshot.appBarHeight,
          duration: Duration(milliseconds: 100));
    });
  }
}
