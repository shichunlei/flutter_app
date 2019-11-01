import 'package:flutter/material.dart';
import 'package:flutter_app/bean/tubitv.dart';
import 'package:flutter_app/page_index.dart';

import 'details.dart';
import 'item_movie.dart';
import 'list_section_title_view.dart';

class ItemHomeView extends StatelessWidget {
  final List<TuBiTV> item;
  final String category;
  final String title;
  final String topImage;

  ItemHomeView(
      {Key key,
      @required this.item,
      @required this.category,
      @required this.title,
      @required this.topImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: <Widget>[
          ListSectionTitleView(
            category: category,
            title: title,
            topImage: topImage,
          ),
          Container(
              height: 250,
              width: Utils.width,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => ItemMovie(
                        title: item[index].title,
                        image: item[index].posterarts.first,
                        onTap: () => pushNewPage(
                            context, DetailsPage(id: item[index].id)),
                      ),
                  itemCount: item.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Gaps.hGap8,
                  physics: BouncingScrollPhysics())),
          Container(
            child: Divider(),
            height: 1.0,
          )
        ],
      ),
    );
  }
}
