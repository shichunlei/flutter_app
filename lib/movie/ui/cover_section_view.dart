import 'package:flutter/material.dart';
import 'package:flutter_app/movie/ui/home_section_view.dart';

class CoverSectionView extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final double height;
  final int size;
  final Widget child;
  final VoidCallback onPressed;
  final bool hiddenMore;

  CoverSectionView(
    this.title, {
    Key key,
    this.backgroundColor,
    this.height,
    this.size,
    this.child,
    this.onPressed,
    this.hiddenMore = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: size == 0,
      child: Column(
        children: <Widget>[
          HomeSectionView(
            "$title（$size）",
            hiddenMore: hiddenMore,
            backgroundColor: backgroundColor,
            textColor: Colors.white,
            onPressed: onPressed,
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(height),
            child: child,
          ),
        ],
      ),
    );
  }
}
