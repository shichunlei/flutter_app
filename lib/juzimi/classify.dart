import 'package:flutter/material.dart';
import 'package:flutter_app/bean/juzimi.dart';
import 'package:flutter_app/juzimi/album.dart';
import 'package:flutter_app/juzimi/book.dart';
import 'package:flutter_app/juzimi/celebrity.dart';

class ClassifyPage extends StatefulWidget {
  final List<MingjuClassify> classify;
  final String title;
  final String flag;

  ClassifyPage(
      {Key key,
      @required this.classify,
      @required this.title,
      @required this.flag})
      : assert(classify != null),
        assert(title != null),
        assert(flag != null),
        super(key: key);

  @override
  createState() => _ClassifyPageState();
}

class _ClassifyPageState extends State<ClassifyPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> titleTabs = [];

  TabController controller;

  @override
  void initState() {
    super.initState();
    widget.classify.forEach((type) {
      titleTabs.add(Tab(text: type.title));
    });

    controller = TabController(
        length: widget.classify.length, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          centerTitle: true,
          title: Text('${widget.title}'),
          bottom: TabBar(
              tabs: titleTabs, controller: controller, isScrollable: true)),
      body: TabBarView(
          controller: controller,
          children: titleTabs.map((page) {
            int index = titleTabs.indexOf(page);
            if (widget.flag == 'book') {
              return BookListPage(category: widget.classify[index].tag);
            } else if (widget.flag == 'celebrity') {
              return CelebrityListPage(category: widget.classify[index].tag);
            } else if (widget.flag == 'album') {
              return AlbumListPage(
                  category:
                      '${widget.classify[index].tag}/${widget.classify[index].id}');
            } else if (widget.flag == 'juji') {
              return Center();
            } else if (widget.flag == 'original') {
              return AlbumListPage(category: '${widget.classify[index].tag}');
            }
          }).toList()),
    );
  }
}
