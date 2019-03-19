import 'package:flutter/material.dart';
import 'package:flutter_app/movie/bean/photos.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MoviePhotoPage extends StatefulWidget {
  final List<Photos> photos;

  MoviePhotoPage({Key key, this.photos}) : super(key: key);

  @override
  _MoviePhotoPageState createState() => _MoviePhotoPageState();
}

class _MoviePhotoPageState extends State<MoviePhotoPage> {
  int total;
  int count = 1;

  @override
  void initState() {
    super.initState();
    total = widget.photos.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PhotoViewGallery(
            pageOptions: _builderPageOptions(widget.photos),
            backgroundDecoration: BoxDecoration(color: Colors.black87),
            onPageChanged: (index) {
              setState(() {
                count = index + 1;
              });
            },
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
          imageProvider: NetworkImage(photos[i].cover),
        ),
      );
    }

    return options;
  }
}
