import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';
import '../../page_index.dart';
import '../page/movie_search_page.dart';

class ItemClassifyTag extends StatefulWidget {
  final String tag;

  const ItemClassifyTag({Key key, this.tag}) : super(key: key);

  @override
  _ItemClassifyTagState createState() => _ItemClassifyTagState();
}

class _ItemClassifyTagState extends State<ItemClassifyTag> {
  String cover =
      "https://ws2.sinaimg.cn/large/006tKfTcgy1g1bt7w7w9mj306e03kmx0.jpg";

  @override
  void initState() {
    super.initState();

    searchMovieByTag(widget.tag);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: <Widget>[
          ImageLoadView(
            cover,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            borderRadius: BorderRadius.circular(3.0),
          ),
          Opacity(
            opacity: 0.5,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
            ),
          ),
          Center(
            child: Text(
              widget.tag,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
      onTap: () => pushNewPage(
          context,
          MovieSearchPage(
            tag: widget.tag,
          )),
    );
  }

  void searchMovieByTag(String tag) async {
    List<Movie> movies =
        await ApiService.getSearchListByTag(tag: tag, start: 0, count: 1);

    if (movies != null && movies.isNotEmpty) {
      setState(() {
        cover = movies[0].images.small.toString();
        print(cover);
      });
    }
  }
}
