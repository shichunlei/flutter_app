import 'package:flutter/material.dart';
import 'package:flutter_app/bean/photos.dart';

import '../page/movie_photo.dart';
import '../ui/item_photo.dart';

import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../page_index.dart';

class MoviePhotosPage extends StatefulWidget {
  final String title;
  final String url;
  final String id;

  MoviePhotosPage(this.title, this.url, this.id);

  @override
  _MoviePhotosPageState createState() => _MoviePhotosPageState();
}

class _MoviePhotosPageState extends State<MoviePhotosPage> {
  List<Photos> photos = [];

  int page = 1;
  int pagesize = 20;

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  bool isFirst = true;

  bool isLoadComplete = false;

  @override
  void initState() {
    super.initState();

    getPhotosList(widget.url, widget.id, (page - 1) * pagesize, page * pagesize,
        RefreshType.DEFAULT);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: _buildBodyView(),
    );
  }

  void getPhotosList(String url, String id, int start, int count,
      RefreshType loadDataType) async {
    List<Photos> _photos =
        await ApiService.getPhotos(url, id, start: start, count: count);

    if (_photos.length < pagesize) {
      Toast.show(context, '数据加载完成...');
      isLoadComplete = true;
    }

    photos.addAll(_photos);
    if (isFirst) {
      isFirst = false;
    }
    setState(() {});
  }

  Widget _buildBodyView() {
    if (isFirst && photos.isEmpty) {
      return getLoadingWidget();
    }
    return EasyRefresh(
      refreshFooter: BallPulseFooter(
        key: _footerKey,
        color: Colors.indigo,
        backgroundColor: Colors.white,
      ),
      loadMore: isLoadComplete
          ? null
          : () async {
              page++;
              getPhotosList(widget.url, widget.id, (page - 1) * pagesize,
                  page * pagesize, RefreshType.LOAD_MORE);
            },
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: photos.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ItemPhoto(photos[index], onTap: () {
            pushNewPage(context,
                MoviePhotoPage(widget.title, photos: photos, index: index));
          });
        },
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      ),
      emptyWidget: Center(child: Text('没有数据！')),
    );
  }
}
