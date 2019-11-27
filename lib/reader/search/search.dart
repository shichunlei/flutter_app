import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();

  List<String> hotWords = [];

  List<String> words = [];

  int total;

  List<String> history = [];

  @override
  void initState() {
    super.initState();

    getSearchHotWords();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Stack(children: <Widget>[
            Column(children: <Widget>[
              Material(
                  color: Colors.white,
                  child: Container(
                      child: Row(children: <Widget>[
                        BackButton(),
                        Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Color(0xFFF5F5F5)),
                                margin: EdgeInsets.fromLTRB(0, 9, 0, 9),
                                child: TextField(
                                    controller: _controller,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.search,
                                    onSubmitted: (s) {
                                      if (_controller.text.isEmpty) {
                                        Toast.show(context, "请输入要搜索的书籍名称");
                                        return;
                                      }
                                      _pushNewPage(_controller.text);
                                    },
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.search,
                                            color: Colors.grey),
                                        hintText: "斗破苍穹",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5),
                                        border: InputBorder.none,
                                        hintMaxLines: 1),
                                    style: TextStyle(
                                        color: Color(0xFF6A6C7A),
                                        fontSize: 16,
                                        textBaseline:
                                            TextBaseline.ideographic)))),
                        IconButton(
                            onPressed: () {
                              if (_controller.text.isEmpty) {
                                Toast.show(context, "请输入要搜索的书籍名称");
                                return;
                              }
                              _pushNewPage(_controller.text);
                            },
                            icon: Text('搜索',
                                style: TextStyle(color: readerMainColor)))
                      ]),
                      height: Utils.navigationBarHeight,
                      padding: EdgeInsets.only(top: Utils.topSafeHeight))),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text('热门推荐', style: TextStyles.textBoldDark26),
                          InkWell(
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text('换一批', style: TextStyles.textGrey14),
                                    Icon(Icons.refresh,
                                        color: Colors.grey, size: 18)
                                  ]),
                              onTap: () => setState(() {
                                    words = hotWords.sublist(7, 12);
                                  }))
                        ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Wrap(
                            children: words
                                .map((word) => ActionChip(
                                    label: Text(word),
                                    onPressed: () => _pushNewPage(word)))
                                .toList(),
                            spacing: 5),
                        Row(children: <Widget>[
                          Text('搜索历史', style: TextStyles.textBoldDark26),
                          InkWell(
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text('清空历史', style: TextStyles.textGrey14),
                                    Icon(Icons.delete,
                                        color: Colors.grey, size: 18)
                                  ]),
                              onTap: () => setState(() => history.clear()))
                        ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        ListView.separated(
                            padding: EdgeInsets.only(top: 0),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (_, index) {
                              return InkWell(
                                  child: Container(
                                      child: Text('${history[index]}'),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      alignment: Alignment.centerLeft),
                                  onTap: () => _pushNewPage(history[index]));
                            },
                            separatorBuilder: (_, index) => Line(
                                margin: EdgeInsets.all(0), color: Colors.grey),
                            itemCount: history.length)
                      ]),
                ),
              )
            ])
          ])),
    );
  }

  void getSearchHotWords() async {
    hotWords = await ApiService.getSearchHotWords();

    total = hotWords.length;

    words = hotWords.sublist(0, 6);

    setState(() {});
  }

  void _pushNewPage(String keyword) {
    setState(() {
      /// 向指定位置添加元素
      history.insert(0, keyword);

      /// 数组去重，可以先toSet()，再toList()，因为Set的子项都是唯一的
      history = history.toSet().toList();
    });
    pushNewPage(context, SearchResultPage(keyword: keyword));
  }
}
