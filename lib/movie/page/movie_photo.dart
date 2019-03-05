import 'package:flutter/material.dart';
import 'package:flutter_app/global/data.dart';
import 'package:flutter_app/movie/bean/photos.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/log_util.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MoviePhotoPage extends StatefulWidget {
  final List<Photos> photos;

  MoviePhotoPage({Key key, this.photos}) : super(key: key);

  @override
  _MoviePhotoPageState createState() => _MoviePhotoPageState();
}

class _MoviePhotoPageState extends State<MoviePhotoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PhotoViewGallery(
          pageOptions: _builderPageOptions(widget.photos),
          backgroundDecoration: BoxDecoration(color: Colors.black87),
          onPageChanged: (index) {
            LogUtil.v('${girls[index].image}');
          },
        ),
      ),
    );
  }

  List<PhotoViewGalleryPageOptions> _builderPageOptions(List<Photos> photos) {
    List<PhotoViewGalleryPageOptions> options = [];

    for (int i = 0; i < photos.length; i++) {
      options.add(
        PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(photos[i].cover),
        ),
      );
    }

    return options;
  }
}
