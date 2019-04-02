import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/movie/bean/photos.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share/share.dart';

class MoviePhotoPage extends StatefulWidget {
  final List<Photos> photos;
  final int index;
  final PageController controller;
  final String title;

  MoviePhotoPage(
    this.title, {
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
            pageOptions: widget.photos
                .map((photo) => PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(photo.cover)))
                .toList(),
            backgroundDecoration: BoxDecoration(color: Colors.black),
            onPageChanged: (index) {
              setState(() => count = index + 1);
            },
            scrollPhysics: const BouncingScrollPhysics(),
            loadingChild: CupertinoActivityIndicator(),
            pageController: widget.controller,
          ),
          Column(
            children: <Widget>[
              AppBar(
                elevation: 1.0,
                backgroundColor: Color(0x2affffff),
                title: Text(widget.title),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        Share.share(widget.photos[count].cover);
                      })
                ],
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ],
      ),
    );
  }
}
