import 'package:flutter/material.dart';
import 'package:flutter_app/bean/casts.dart';
import '../page/movie_celebrity.dart';
import 'person_gridview.dart';
import 'package:flutter_app/utils/route_util.dart';

class PersonScroller extends StatelessWidget {
  final List<Casts> casts;
  final double height;
  final EdgeInsets padding;

  PersonScroller({
    Key key,
    @required this.casts,
    this.height = 110.0,
    this.padding =
        const EdgeInsets.only(top: 10, left: 5.0, right: 5.0, bottom: 0.0),
  })  : assert(casts != null),
        assert(height != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
        size: Size.fromHeight(height),
        child: Padding(
            padding: padding,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: casts.length,
                itemBuilder: (context, index) => PersonGridView(
                    casts: casts[index],
                    textColor: Colors.white,
                    onTap: () => pushNewPage(
                        context,
                        MovieCelebrityPage(
                            id: casts[index].id, name: casts[index].name))))));
  }
}
