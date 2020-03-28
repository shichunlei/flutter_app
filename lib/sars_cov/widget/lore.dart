import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_app/sars_cov/ui/item_lore.dart';

import 'title_container.dart';

class LoreView extends StatelessWidget {
  final List<WikiListBean> wikiList;

  LoreView({Key key, @required this.wikiList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(children: [
        TitleContainer(title: "疾病知识"),
        ListView.separated(
            itemBuilder: (_, index) {
              return ItemLore(wiki: wikiList[index]);
            },
            separatorBuilder: (_, index) => Gaps.vGap4,
            itemCount: wikiList.length,
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.zero)
      ]),
    );
  }
}
