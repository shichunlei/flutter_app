import 'package:clippy_flutter/diagonal.dart';
import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemRange extends StatelessWidget {
  final CoverBean info;
  final VoidCallback onPressed;
  final String year;

  ItemRange({Key key, this.info, this.onPressed, this.year}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BouncingView(
      child: Card(
        elevation: 5.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Stack(
          children: <Widget>[
            ImageLoadView('${info?.backgroundImg}',
                width: double.infinity, height: double.infinity, radius: 10),
            Diagonal(
              clipHeight: 40.0,
              axis: Axis.vertical,
              position: DiagonalPosition.TOP_RIGHT,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(Utils.getColorHexFromStr(
                        '${info?.primaryColorDark}',
                        alpha: "A9")),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0))),
                width: 120.0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 20),
                    child: Text(
                      '${info?.title?.replaceAll("$year", "")?.replaceAll("的", "\n")?.replaceAll("|", "")}',
                      style: TextStyles.textWhite16,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
