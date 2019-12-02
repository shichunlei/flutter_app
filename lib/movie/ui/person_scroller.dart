import 'package:flutter/material.dart';
import 'package:flutter_app/utils/route_util.dart';

import '../index.dart';

class PersonScroller extends StatelessWidget {
  final List<Casts> casts;

  PersonScroller({Key key, @required this.casts})
      : assert(casts != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120.0,
        padding:
            const EdgeInsets.only(top: 10, left: 5.0, right: 5.0, bottom: 0.0),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: casts.length,
            itemBuilder: (context, index) => PersonGridView(
                casts: casts[index],
                textColor: Colors.white,
                onTap: () {
                  if (casts[index].id != null)
                    pushNewPage(
                        context,
                        MovieCelebrityPage(
                            id: casts[index].id, name: casts[index].name));
                })));
  }
}
