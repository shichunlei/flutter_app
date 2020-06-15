import 'package:clippy_flutter/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';

import 'package:flutter_html/flutter_html.dart';

import '../page_index.dart';
import 'index.dart';

class OneArticlePage extends StatefulWidget {
  @override
  createState() => _OneArticlePageState();
}

class _OneArticlePageState extends State<OneArticlePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  void initState() {
    super.initState();
    Future.microtask(() =>
        Store.value<ArticleModel>(context, listen: false).getArticle('today'));
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: themeColors[
                Store.value<ArticleModel>(context).getThemeColorIndex()],
            centerTitle: true,
            title: Text('每日一文'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => _showModalBottomSheet())
            ]),
        body: Store.connect<ArticleModel>(
            builder: (_, ArticleModel articleModel, __) {
          return LoaderContainer(
              contentView: bodyView(articleModel),
              loaderState: articleModel.status);
        }));
  }

  Widget bodyView(ArticleModel articleModel) {
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
            alignment: Alignment.topCenter,
            child: Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(articleModel.article?.title ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: articleModel.getTextSize() + 1))),
              Label(
                  triangleHeight: 10.0,
                  edge: Edge.RIGHT,
                  child: Container(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 18.0, top: 8.0, bottom: 8.0),
                      color: themeColors[articleModel.getThemeColorIndex()],
                      child: Text(articleModel.article?.author ?? '',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: articleModel.getTextSize() - 1)))),
              Html(
                  data: articleModel.article?.content ?? '',
                  defaultTextStyle:
                      TextStyle(fontSize: articleModel.getTextSize()),
                  padding: EdgeInsets.all(8.0),
                  blockSpacing: 2.0,
                  useRichText: true,
                  linkStyle: const TextStyle(
                      color: Colors.redAccent,
                      decorationColor: Colors.redAccent,
                      decoration: TextDecoration.underline),
                  onLinkTap: (url) {
                    debugPrint("Opening $url...");
                  })
            ])));
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              padding: EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                _buildFontSizeSelector(),
                _buildThemeSelector(),
                _buildArticleChange(),
                _buildCollect()
              ], mainAxisAlignment: MainAxisAlignment.spaceEvenly));
        });
  }

  Widget _buildFontSizeSelector() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text('字号'),
      Expanded(child: Store.connect<ArticleModel>(
          builder: (_, ArticleModel articleModel, __) {
        return Slider(
            onChanged: (double value) {
              double valueRound = value.roundToDouble();
              SpUtil.setDouble('article_font_size', valueRound);
              articleModel.setTextSize(valueRound);
            },
            divisions: 16,
            label: "${articleModel.getTextSize().round()}",
            value: articleModel.getTextSize(),
            activeColor: themeColors[articleModel.getThemeColorIndex()],
            min: 10,
            max: 26);
      }))
    ]);
  }

  Widget _buildThemeSelector() {
    return Store.connect<ArticleModel>(
        builder: (_, ArticleModel articleModel, __) {
      if (_tabController == null) {
        _tabController = TabController(
            length: themeColors.length,
            vsync: this,
            initialIndex: articleModel.getThemeColorIndex());
      }

      List<Tab> tabs = List();
      for (Color color in themeColors) {
        tabs.add(Tab(icon: Icon(Icons.markunread_mailbox, color: color)));
      }

      return Row(children: <Widget>[
        Text('主题'),
        Gaps.hGap5,
        Expanded(
            child: TabBar(
                tabs: tabs,
                isScrollable: true,
                controller: _tabController,
                indicatorPadding: const EdgeInsets.only(left: 5, right: 5),
                onTap: (int index) {
                  SpUtil.setInt('themeIndex', index);
                  articleModel.setThemeColorIndex(index);
                },
                indicatorColor: themeColors[articleModel.getThemeColorIndex()]))
      ]);
    });
  }

  Widget _buildArticleChange() {
    return Store.connect<ArticleModel>(
        builder: (_, ArticleModel articleModel, __) {
      return Row(children: <Widget>[
        Expanded(
            child: RaisedButton(
                color: themeColors[articleModel.getThemeColorIndex()],
                onPressed: () {
                  Navigator.pop(context);
                  articleModel.setPageStatus(LoaderState.Loading);
                  articleModel.getArticle('day',
                      date: articleModel.article.prev);
                },
                child: Text('前一天', style: TextStyle(color: Colors.white)),
                shape: const StadiumBorder())),
        Gaps.hGap5,
        Expanded(
            child: RaisedButton(
                color: themeColors[articleModel.getThemeColorIndex()],
                onPressed: () {
                  Navigator.pop(context);
                  articleModel.setPageStatus(LoaderState.Loading);
                  articleModel.getArticle('random');
                },
                child: Text('随机', style: TextStyle(color: Colors.white)),
                shape: const StadiumBorder())),
        Gaps.hGap5,
        Expanded(
            child: RaisedButton(
                color: themeColors[articleModel.getThemeColorIndex()],
                onPressed: articleModel.date != articleModel.today
                    ? () {
                        Navigator.pop(context);
                        articleModel.setPageStatus(LoaderState.Loading);
                        articleModel.getArticle('day',
                            date: articleModel.article.next);
                      }
                    : null,
                child: Text('后一天', style: TextStyle(color: Colors.white)),
                shape: const StadiumBorder())),
        Gaps.hGap5,
        Expanded(
            child: RaisedButton(
                color: themeColors[articleModel.getThemeColorIndex()],
                onPressed: () {
                  Navigator.pop(context);
                  articleModel.setPageStatus(LoaderState.Loading);
                  articleModel.getArticle('today');
                },
                shape: const StadiumBorder(),
                child: Text('今天', style: TextStyle(color: Colors.white))))
      ]);
    });
  }

  Widget _buildCollect() {
    return Store.connect<ArticleModel>(
        builder: (_, ArticleModel articleModel, __) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
          Widget>[
        MaterialButton(
            onPressed: () =>
                articleModel.setStarStatus(article: articleModel.article),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(articleModel.starStatus ? Icons.star : Icons.star_border,
                      color: Colors.white),
                  Text(articleModel.starStatus ? '已收藏' : '收藏',
                      style: TextStyle(color: Colors.white))
                ]),
            color: themeColors[articleModel.getThemeColorIndex()],
            shape: const StadiumBorder()),
        MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              pushNewPage(
                  context, CollectArticle(Theme.of(context).primaryColor),
                  callBack: (value) {
                articleModel.setPageStatus(LoaderState.Loading);
                if (value != null) {
                  debugPrint('-----------------------------$value');
                  articleModel.getArticle('day', date: value);
                } else {
                  debugPrint('-----------------------------');
                  articleModel.getArticle('day',
                      date: Store.value<ArticleModel>(context).date);
                }
              });
            },
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.list, color: Colors.white),
                  Text('收藏列表', style: TextStyle(color: Colors.white))
                ]),
            color: themeColors[articleModel.getThemeColorIndex()],
            shape: const StadiumBorder())
      ]);
    });
  }
}
