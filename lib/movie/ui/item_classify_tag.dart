import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';
import 'package:flutter_app/movie/page/movie_tag_list.dart';
import '../../page_index.dart';

class ItemClassifyTag extends StatefulWidget {
  final String tag;

  ItemClassifyTag({Key key, this.tag}) : super(key: key);

  @override
  createState() => _ItemClassifyTagState();
}

class _ItemClassifyTagState extends State<ItemClassifyTag>
    with AutomaticKeepAliveClientMixin<ItemClassifyTag> {
  String cover = backgroundImage;

  @override
  void initState() {
    super.initState();

    searchMovieByTag(widget.tag);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTapView(
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
      onPressed: () => pushNewPage(context, MovieTagListView(widget.tag)),
    );
  }

  void searchMovieByTag(String tag) async {
    List<Movie> movies =
        await ApiService.getSearchListByTag(tag, page: 0, limit: 1);

    if (movies != null && movies.isNotEmpty) {
      setState(() {
        cover = movies[0].images.small.toString();
        print(cover);
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
