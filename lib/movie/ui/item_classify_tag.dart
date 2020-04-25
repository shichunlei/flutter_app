import 'package:flutter/material.dart';
import '../../page_index.dart';
import '../index.dart';

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
    super.build(context);
    return BouncingView(
      child: Stack(
        children: <Widget>[
          ImageLoadView(cover,
              width: double.infinity, height: double.infinity, radius: 3),
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
        cover = movies?.first?.images?.small.toString();
        print(cover);
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
