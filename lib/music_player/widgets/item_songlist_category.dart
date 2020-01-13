import 'package:flutter/material.dart';
import '../../page_index.dart';
import '../index.dart';

class ItemSongListCategory extends StatelessWidget {
  final MusicCategory category;
  final double height;

  ItemSongListCategory(
      {Key key, @required this.category, @required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.5),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            color: Colors.white,
            width: Utils.width / 4.5,
            height: height,
            child: Text('${category.title}'),
          ),
          Gaps.hGap3,
          Expanded(
            child: GridView.builder(
              itemCount: category.list.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3.0,
                  crossAxisSpacing: 3.0,
                  childAspectRatio: 1.65),
              itemBuilder: (_, index) => Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () => pushNewPage(context, SongListDetailsPage()),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '${category.list[index].label}',
                      style: TextStyles.textBoldDark16,
                    ),
                  ),
                ),
              ),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
            ),
          ),
        ],
      ),
    );
  }
}
