import 'package:clippy_flutter/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/article.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/log_util.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class OneArticlePage extends StatefulWidget {
  OneArticlePage({Key key}) : super(key: key);

  @override
  _OneArticlePageState createState() => _OneArticlePageState();
}

class _OneArticlePageState extends State<OneArticlePage> {
  bool isShowLoading = false;

  Article article;

  @override
  void initState() {
    super.initState();

    getArticle('today');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('每日一文'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              showLoadingDialog(context, "正在加载...");
              isShowLoading = true;
              article = null;
              getArticle('random');
            },
          ),
          IconButton(
            icon: Icon(Icons.date_range),
            onPressed: () {
              showLoadingDialog(context, "正在加载...");
              isShowLoading = true;
              article = null;
              getArticle('day');
            },
          ),
        ],
      ),
      body: _buildBodyView(),
    );
  }

  void getArticle(type, {date}) async {
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
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
              ),
            ),
            Label(
              triangleHeight: 10.0,
              edge: Edge.RIGHT,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 18.0, top: 8.0, bottom: 8.0),
                color: Colors.green,
                child: Text(
                  article.author,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Html(
              data: article.content,
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
}
