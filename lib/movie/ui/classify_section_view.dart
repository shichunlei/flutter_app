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

/// 类型
const GenreList = [
  '剧情',
  '喜剧',
  '动作',
  '爱情',
  '科幻',
  '动画',
  '纪录片',
  '悬疑',
  '惊悚',
  '恐怖',
  '犯罪',
  '奇幻',
  '冒险',
  '灾难',
  '武侠',
  '音乐',
  '歌舞',
  '传记',
  '历史',
  '战争',
  '同性',
  '西部',
  '情色'
];

/// 地区
const RegionList = [
  '中国大陆',
  '美国',
  '香港',
  '日本',
  '韩国',
  '台湾',
  '英国',
  '法国',
  '德国',
  '意大利',
  '西班牙',
  '印度',
  '泰国',
  '俄罗斯',
  '伊朗',
  '加拿大',
  '澳大利亚',
  '爱尔兰',
  '瑞典',
  '巴西',
  '丹麦'
];

/// 特色
const FeatureList = [
  '经典',
  '青春',
  '治愈',
  '文艺',
  '女性',
  '小说改编',
  '超级英雄',
  '美食',
  '宗教',
  '励志',
  '魔幻',
  '黑帮',
  '感人'
];

/// 年代
const YearList = [
  '2019',
  '2018',
  '2010年代',
  '2000年代',
  '90年代',
  '80年代',
  '70年代',
  '60年代',
  '更早'
];
