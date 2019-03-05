import 'package:flutter/material.dart';
import 'package:flutter_app/global/data.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/log_util.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MoviePhotoPage extends StatefulWidget {
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
          pageOptions: <PhotoViewGalleryPageOptions>[
            PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(girls[0].image)),
            PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(girls[1].image),
                maxScale: PhotoViewComputedScale.contained * 0.3),
            PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(girls[2].image),
              initialScale: PhotoViewComputedScale.contained * 0.98,
            ),
            PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(girls[3].image)),
          ],
          backgroundDecoration: BoxDecoration(color: Colors.black87),
          loadingChild: getLoadingWidget(),
          onPageChanged: (index) {
            LogUtil.v('${girls[index].image}');
          },
        ),
      ),
    );
  }
}
