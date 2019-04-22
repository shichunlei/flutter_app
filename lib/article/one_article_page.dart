import 'package:clippy_flutter/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/article/collect_article.dart';
import 'package:flutter_app/article/db/article_provider.dart';
import 'package:flutter_app/bean/article.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/log_util.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_app/utils/sp_util.dart';
import 'package:flutter_app/utils/time_utils.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class OneArticlePage extends StatefulWidget {
  final String date;

  OneArticlePage({Key key, this.date}) : super(key: key);

  @override
  _OneArticlePageState createState() => _OneArticlePageState();
}

class _OneArticlePageState extends State<OneArticlePage>
    with SingleTickerProviderStateMixin {
  bool isShowLoading = false;
  bool isFirst = true;
  bool starred = false;

  Article article;

  ArticleProvider provider;

  double _fontSize;
  int _themeColorIndex;

  TabController _tabController;

  String _date;
  String today =
      TimeUtils.getDateStrByDateTime(DateTime.now(), format: DateFormat.YMD);

  @override
  void initState() {
    super.initState();

    _fontSize = SPUtil.getDouble('article_font_size', defValue: 18.0);
    setState(() {
      _themeColorIndex = SPUtil.getInt('themeIndex', defValue: 0);
    });

    _tabController = TabController(
      length: themeColors.length,
      vsync: this,
      initialIndex: _themeColorIndex,
    );

    provider = ArticleProvider();

    LogUtil.v('${widget.date}================');

    if (widget.date == null) {
      getArticle('today');
    } else {
      getArticle('day', date: widget.date);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColors[_themeColorIndex],
        centerTitle: true,
        title: Text('每日一文'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (builder) {
                  collectState(_date);
                  return StatefulBuilder(
                    builder: (context, mSetState) {
                      return Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            _buildFontSizeSelector(mSetState),
                            _buildThemeSelector(mSetState),
                            _buildArticleChange(mSetState),
                            _buildCollect(_date, mSetState),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      );
                    },
                  );
                },
              );
            },
          )
        ],
      ),
      body: _buildBodyView(),
    );
  }

  void getArticle(type, {date}) async {
    if (!isFirst) {
      showLoadingDialog(context, "正在加载...");
      isShowLoading = true;
      article = null;
    }

    if (type == 'today') {
      article = await ApiService.getTodayArticle();
    } else if (type == 'random') {
      article = await ApiService.getRandomArticle();
    } else if (type == 'day') {
      article = await ApiService.getDayArticle(date);
    }
    if (isShowLoading) {
      Navigator.of(context).pop();
      isShowLoading = false;
    }
    _date = article.date.curr;
    LogUtil.v(_date.toString());
    isFirst = false;
    collectState(_date);
    setState(() {});
  }

  Widget _buildBodyView() {
    if (article == null) {
      return getLoadingWidget();
    }
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                article.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: _fontSize + 1),
              ),
            ),
            Label(
              triangleHeight: 10.0,
              edge: Edge.RIGHT,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 18.0, top: 8.0, bottom: 8.0),
                color: themeColors[_themeColorIndex],
                child: Text(
                  article.author,
                  style:
                      TextStyle(color: Colors.white, fontSize: _fontSize - 1),
                ),
              ),
            ),
            Html(
              data: article.content,
              defaultTextStyle: TextStyle(fontSize: _fontSize),
              // Optional parameters:
              padding: EdgeInsets.all(8.0),
              blockSpacing: 2.0,
              useRichText: true,
              linkStyle: const TextStyle(
                color: Colors.redAccent,
                decorationColor: Colors.redAccent,
                decoration: TextDecoration.underline,
              ),
              onLinkTap: (url) {
                LogUtil.v("Opening $url...");
              },
              customRender: (node, children) {
                if (node is dom.Element) {
                  switch (node.localName) {
                    case "custom_tag":
                      return Column(children: children);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFontSizeSelector(mSetState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('字号'),
        Expanded(
          child: Slider(
            onChanged: (double value) {
              double valueRound = value.roundToDouble();
              SPUtil.putDouble('article_font_size', valueRound);
              mSetState(() {});
              setState(() {
                _fontSize = valueRound;
              });
            },
            divisions: 16,
            label: "${_fontSize.round()}",
            value: _fontSize,
            activeColor: themeColors[_themeColorIndex],
            min: 10,
            max: 26,
          ),
        ),
      ],
    );
  }

  Widget _buildThemeSelector(mSetState) {
    List<Tab> tabs = List();
    for (Color color in themeColors) {
      tabs.add(Tab(icon: Icon(Icons.markunread_mailbox, color: color)));
    }

    return Row(
      children: <Widget>[
        Text('主题'),
        SizedBox(width: 5),
        Expanded(
            child: TabBar(
          tabs: tabs,
          isScrollable: true,
          controller: _tabController,
          indicatorPadding: const EdgeInsets.only(left: 5, right: 5),
          onTap: (int index) {
            SPUtil.putInt('themeIndex', index);
            setState(() {
              _themeColorIndex = index;
            });
            mSetState(() {});
          },
          indicatorColor: themeColors[_themeColorIndex],
        ))
      ],
    );
  }

  Widget _buildArticleChange(mSetState) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            color: themeColors[_themeColorIndex],
            onPressed: () {
              Navigator.pop(context);
              getArticle('day', date: article.date.prev);
              mSetState(() {});
            },
            child: Text('前一天', style: TextStyle(color: Colors.white)),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: RaisedButton(
            color: themeColors[_themeColorIndex],
            onPressed: () {
              Navigator.pop(context);
              getArticle('random');
              mSetState(() {});
            },
            child: Text('随机', style: TextStyle(color: Colors.white)),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: RaisedButton(
            color: themeColors[_themeColorIndex],
            onPressed: _date != today
                ? () {
                    Navigator.pop(context);
                    getArticle('day', date: article.date.next);
                    mSetState(() {});
                  }
                : null,
            child: Text('后一天', style: TextStyle(color: Colors.white)),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: RaisedButton(
            color: themeColors[_themeColorIndex],
            onPressed: () {
              Navigator.pop(context);
              getArticle('today');
              mSetState(() {});
            },
            child: Text('今天', style: TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }

  Widget _buildCollect(String date, mSetState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        MaterialButton(
          onPressed: () {
            if (starred) {
              starred = false;
              provider.cancelStarred(date);
            } else {
              starred = true;
              provider.insertOrReplaceToDB(article);
            }
            setState(() {});
            mSetState(() {});
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(starred ? Icons.star : Icons.star_border,
                  color: Colors.white),
              Text(starred ? '已收藏' : '收藏',
                  style: TextStyle(color: Colors.white))
            ],
          ),
          color: themeColors[_themeColorIndex],
        ),
        MaterialButton(
          onPressed: () {
            getList();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.list, color: Colors.white),
              Text('收藏列表', style: TextStyle(color: Colors.white))
            ],
          ),
          color: themeColors[_themeColorIndex],
        ),
      ],
    );
  }

  void collectState(date) async {
    starred = await provider.isCollection(date);
    setState(() {});
  }

  void getList() async {
    List<Article> list = await provider.getStarredList();
    if (list.length > 0) {
      Navigator.pop(context);
      LogUtil.v(list.toString());
      pushNewPage(context, CollectArticle(themeColors[_themeColorIndex], list));
    } else {
      Toast.show('暂无收藏', context);
    }
  }
}
