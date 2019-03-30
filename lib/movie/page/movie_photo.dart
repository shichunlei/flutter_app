import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/movie/bean/photos.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MoviePhotoPage extends StatefulWidget {
  final List<Photos> photos;
  final int index;
  PageController controller;

  MoviePhotoPage({
    Key key,
    this.photos,
    this.index = 0,
  })  : controller = PageController(initialPage: index),
        super(key: key);

  @override
  _MoviePhotoPageState createState() => _MoviePhotoPageState();
}

class _MoviePhotoPageState extends State<MoviePhotoPage> {
  int total;
  int count;

  @override
  void initState() {
    super.initState();
    total = widget.photos.length;
    count = 1 + widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          PhotoViewGallery(
            pageOptions: _builderPageOptions(widget.photos),
            backgroundDecoration: BoxDecoration(color: Colors.black),
            onPageChanged: (index) {
              setState(() => count = index + 1);
            },
            scrollPhysics: const BouncingScrollPhysics(),
            loadingChild: CupertinoActivityIndicator(),
            pageController: widget.controller,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 40.0),
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 80.0,
              height: 30.0,
              child: Center(
                child: Text('$count/$total',
                    style: TextStyle(color: Colors.white)),
              ),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
            ),
          ),
        ],
      ),
    );
  }

  List<PhotoViewGalleryPageOptions> _builderPageOptions(List<Photos> photos) {
    List<PhotoViewGalleryPageOptions> options = [];

    for (int i = 0; i < photos.length; i++) {
      options.add(
        PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(photos[i].cover), heroTag: 'photo$i'),
      );
    }

    return options;
  }
}
