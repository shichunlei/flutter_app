import 'package:flutter/material.dart';
import 'item_classify_tag.dart';

import '../../page_index.dart';

class ClassifySectionView extends StatelessWidget {
  final String title;

  ClassifySectionView(this.title);

  @override
  Widget build(BuildContext context) {
    List<String> classifyList;

    switch (title) {
      case '类型':
        classifyList = GenreList;
        break;
      case '地区':
        classifyList = RegionList;
        break;
      case '年代':
        classifyList = YearList;
        break;
      case '特色':
        classifyList = FeatureList;
        break;
      default:
    }

    return SectionView(
      title,
      hiddenMore: true,
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: GridView.builder(
          itemCount: classifyList.length,
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            childAspectRatio: 1.8,
          ),
          itemBuilder: (context, index) =>
              ItemClassifyTag(tag: classifyList[index]),
        ),
      ),
    );
  }
}
