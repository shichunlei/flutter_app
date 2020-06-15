import 'package:flutter/material.dart';

import '../../page_index.dart';

class ChoiceTagPage extends StatefulWidget {
  ChoiceTagPage({Key key}) : super(key: key);

  @override
  createState() => _ChoiceTagPageState();
}

class _ChoiceTagPageState extends State<ChoiceTagPage> {
  List<String> tags = [];

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(children: <Widget>[
            AppBar(automaticallyImplyLeading: false),
            Positioned(
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Text('选择您的阅读偏好', style: TextStyles.textBoldDark20),
                    Text('(最多选5个)', style: TextStyles.textGrey16)
                  ], crossAxisAlignment: CrossAxisAlignment.end),
                  Text('让我们更好的为您服务', style: TextStyles.textGrey16)
                ], crossAxisAlignment: CrossAxisAlignment.start),
                top: Utils.navigationBarHeight,
                left: 20),
            Positioned(
                child: Column(children: <Widget>[
                  Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Icon(CustomIcon.male,
                        color: Colors.lightBlueAccent, size: 18),
                    Gaps.hGap5,
                    Text('男生爱看',
                        style: TextStyle(color: Colors.lightBlueAccent))
                  ]),
                  Gaps.vGap20,
                  Wrap(spacing: 5, children: <Widget>[
                    ChoiceChip(label: Text('都市'), selected: false),
                    ChoiceChip(label: Text('玄幻'), selected: false),
                    ChoiceChip(label: Text('仙侠'), selected: false),
                    ChoiceChip(label: Text('游戏'), selected: false),
                    ChoiceChip(label: Text('历史'), selected: false),
                    ChoiceChip(label: Text('科幻'), selected: false),
                    ChoiceChip(label: Text('奇幻'), selected: false),
                    ChoiceChip(label: Text('武侠'), selected: false),
                    ChoiceChip(label: Text('职场'), selected: false),
                    ChoiceChip(label: Text('军事'), selected: false),
                    ChoiceChip(label: Text('竞技'), selected: false),
                    ChoiceChip(label: Text('灵异'), selected: false),
                    ChoiceChip(label: Text('轻小说'), selected: false),
                    ChoiceChip(label: Text('同人'), selected: false)
                  ]),
                  Gaps.vGap15,
                  Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Icon(CustomIcon.female, color: Colors.redAccent, size: 18),
                    Gaps.hGap5,
                    Text('女生爱看', style: TextStyle(color: Colors.redAccent))
                  ]),
                  Gaps.vGap20,
                  Wrap(spacing: 5, children: <Widget>[
                    ChoiceChip(
                        label: Text('现代言情'),
                        selected: false,
                        onSelected: (value) {}),
                    ChoiceChip(label: Text('古代言情'), selected: false),
                    ChoiceChip(label: Text('青春校园'), selected: false),
                    ChoiceChip(label: Text('纯爱'), selected: false),
                    ChoiceChip(label: Text('武侠仙侠'), selected: false),
                    ChoiceChip(label: Text('科幻'), selected: false),
                    ChoiceChip(label: Text('玄幻奇幻'), selected: false),
                    ChoiceChip(label: Text('悬疑灵异'), selected: false),
                    ChoiceChip(label: Text('同人'), selected: false),
                    ChoiceChip(label: Text('女尊'), selected: false),
                    ChoiceChip(label: Text('莉莉'), selected: false),
                    ChoiceChip(label: Text('游戏竞技'), selected: false)
                  ])
                ]),
                top: 70 + Utils.navigationBarHeight,
                left: 0,
                right: 0),
            Positioned(
                child: Align(
                    child: Button(
                        onPressed: () {},
                        width: 120,
                        child: Text("开始阅读之旅", style: TextStyle(fontSize: 14)),
                        halfRadius: true,
                        color: readerMainColor)),
                bottom: 20,
                left: 0,
                right: 0)
          ])),
    );
  }
}
