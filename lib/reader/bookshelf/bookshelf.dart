import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/store/index.dart';

import '../../page_index.dart';
import '../index.dart';

class BookShelfPage extends StatefulWidget {
  BookShelfPage({Key key}) : super(key: key);

  @override
  createState() => _BookShelfPageState();
}

class _BookShelfPageState extends State<BookShelfPage> {
  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
          appBar: AppBar(
              title: Text('书架', style: TextStyle(color: Colors.black54)),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => pushNewPage(context, SearchPage())),
              ]),
          body: Store.connect<BookModel>(builder:
              (BuildContext context, BookModel snapshot, Widget child) {
            return LoaderContainer(
                contentView: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    itemBuilder: (_, index) {
                      return ItemBookShelf(
                          book: snapshot.books.length == index
                              ? null
                              : snapshot.books[index],
                          onPressed: () {
                            if (snapshot.books.length == index) {
                              pushNewPage(context, SearchPage());
                            } else {
                              pushNewPage(
                                  context,
                                  BookDetailsPage(
                                      id: snapshot.books[index].id,
                                      imageUrl: snapshot.books[index].cover));
                            }
                          },
                          onLongPress: () {
                            if (snapshot.books.length > index)
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('提示'),
                                      content: Text(
                                          '您确定要删除《${snapshot.books[index].title}》吗？'),
                                      contentPadding: EdgeInsets.all(20),
                                      titlePadding:
                                          EdgeInsets.only(top: 20, left: 20),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text(S.of(context).cancel)),
                                        FlatButton(
                                            onPressed: () {
                                              snapshot.deleteBook(context,
                                                  snapshot.books[index].id);
                                              Navigator.pop(context);
                                            },
                                            child: Text(S.of(context).sure)),
                                      ],
                                    );
                                  });
                          },
                          progress: snapshot.books.length == index
                              ? 0.0
                              : snapshot.books[index].progress,
                          showAddBookshelfItem: snapshot.books.length > 0);
                    },
                    itemCount: snapshot.books.length > 0
                        ? snapshot.books.length + 1
                        : snapshot.books.length,
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true),
                loaderState: snapshot.status,
                emptyView: EmptyPage(
                    text: '比撸猫更重要的，只有看书了...',
                    onPresses: () => pushNewPage(context, SearchPage()),
                    pressText: '添加书籍'));
          })),
    );
  }
}
