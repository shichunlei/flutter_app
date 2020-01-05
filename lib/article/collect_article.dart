import 'package:flutter/material.dart';

import '../page_index.dart';
import 'index.dart';

class CollectArticle extends StatefulWidget {
  final Color themeColor;

  CollectArticle(this.themeColor, {Key key}) : super(key: key);

  @override
  createState() => _CollectArticleState();
}

class _CollectArticleState extends State<CollectArticle> {
  ArticleProvider provider = ArticleProvider();

  var data;

  @override
  void initState() {
    super.initState();

    data = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.themeColor,
        title: Text('我的收藏'),
      ),
      body: _buildBodyView(),
    );
  }

  Widget _buildBodyView() {
    return FutureBuilder<List<Article>>(
        future: data,
        builder: (_, AsyncSnapshot<List<Article>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              debugPrint('none');
              return Text('');
            case ConnectionState.waiting:
              debugPrint('waiting');
              return LoadingWidget();
            case ConnectionState.done:
              debugPrint('done');
              if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                return ErrorPage(text: '网络请求错误');
              } else {
                debugPrint('${snapshot.data.length}');
                if (snapshot.data.length > 0) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final item = snapshot.data[index].curr;
                      return GestureDetector(
                        child: Dismissible(
                          key: Key(item),
                          onDismissed: (direction) async {
                            provider
                                .cancelStarred(snapshot.data[index].curr)
                                .then((_) {
                              setState(() {
                                snapshot.data.removeAt(index);
                              });
                            });
                          },
                          child: Card(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('${snapshot.data[index]?.title}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0)),
                                      Text('${snapshot.data[index]?.curr}'),
                                    ],
                                  ),
                                  Text(
                                    '${snapshot.data[index]?.digest}',
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 14.0),
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
                          Navigator.of(context).pop(snapshot.data[index].curr);
                        },
                      );
                    },
                    itemCount: snapshot.data.length,
                  );
                }
                return EmptyPage(text: '暂无收藏', imageAsset: 'images/empty.jpeg');
              }
              break;
            default:
              return EmptyPage(text: '暂无收藏', imageAsset: 'images/empty.jpeg');
          }
        });
  }

  Future<List<Article>> fetchData() async {
    return await provider.getStarredList();
  }
}
