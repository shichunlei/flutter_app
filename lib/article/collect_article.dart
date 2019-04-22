import 'package:flutter/material.dart';
import 'package:flutter_app/article/db/article_provider.dart';
import 'package:flutter_app/article/one_article_page.dart';
import 'package:flutter_app/bean/article.dart';
import 'package:flutter_app/utils/route_util.dart';

class CollectArticle extends StatefulWidget {
  final Color themeColor;
  final List<Article> list;

  CollectArticle(this.themeColor, this.list, {Key key}) : super(key: key);

  @override
  _CollectArticleState createState() => _CollectArticleState();
}

class _CollectArticleState extends State<CollectArticle> {
  ArticleProvider provider = ArticleProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.themeColor,
        title: Text('我的收藏'),
      ),
      body: widget.list.length > 0
          ? ListView.builder(
              itemBuilder: (context, index) {
                final item = widget.list[index].curr;
                return GestureDetector(
                  child: Dismissible(
                    key: Key(item),
                    onDismissed: (direction) {
                      provider.cancelStarred(widget.list[index].curr);
                      setState(() {
                        widget.list.removeAt(index);
                      });
                    },
                    child: Card(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(widget.list[index].title,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20.0)),
                                Text(widget.list[index].curr),
                              ],
                            ),
                            Text(
                              widget.list[index].digest,
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 14.0),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                    ),
                    background: Container(
                      color: Colors.red,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    pushNewPage(context, OneArticlePage(date: widget.list[index].curr));
                  },
                );
              },
              itemCount: widget.list.length,
            )
          : Center(
              child: Text('暂无收藏'),
            ),
    );
  }
}
