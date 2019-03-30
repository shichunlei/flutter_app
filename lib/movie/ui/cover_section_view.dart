import 'package:flutter/material.dart';
import 'package:flutter_app/movie/ui/home_section_view.dart';

class CoverSectionView extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final double height;
  final int size;
  final Widget child;

  CoverSectionView(
    this.title, {
    Key key,
    this.backgroundColor,
    this.height,
    this.size,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: size == 0,
      child: Column(
        children: <Widget>[
          HomeSectionView(
            "$title（${size}）",
            hiddenMore: true,
            backgroundColor: backgroundColor,
            textColor: Colors.white,
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(height),
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
