import 'package:flutter/material.dart';
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
          body: FutureBuilder(
              future: Store.value<BookModel>(context).getBooks(),
              builder: (_, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('Press button to start.');
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Center(child: LoadingWidget());
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      debugPrint(snapshot.error);
                      return ErrorPage();
                    }

                    List<Books> items = snapshot.data;

                    if (items == null || items.length == 0) {
                      return EmptyPage(
                          text: '比撸猫更重要的，只有看书了...',
                          onPresses: () => pushNewPage(context, SearchPage()),
                          pressText: '添加书籍');
                    }

                    return initView(items);
                }

                return null;
              })),
    );
  }

  Widget initView(List<Books> books) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.6,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemBuilder: (_, index) {
          return ItemBookShelf(
              book: books.length == index ? null : books[index],
              onPressed: () {
                if (books.length == index) {
                  pushNewPage(context, SearchPage());
                } else {
                  pushNewPage(
                      context,
                      BookDetailsPage(
                          id: books[index].id, imageUrl: books[index].cover));
                }
              },
              onLongPress: () {
                if (books.length > index) showDelDialog(books, index);
              },
              progress: books.length == index ? 0.0 : books[index].progress,
              showAddBookshelfItem: books.length > 0);
        },
        itemCount: books.length > 0 ? books.length + 1 : books.length,
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true);
  }

  void showDelDialog(List<Books> books, int index) {
    showDiffDialog(
      context,
      title: Text('提示'),
      content: Text('您确定要删除《${books[index].title}》吗？'),
      pressed: () {
        Store.value<BookModel>(context, listen: false)
            .deleteBook(context, books[index].id);
        Navigator.pop(context);
      },
    );
  }
}
