import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../page_index.dart';
import '../index.dart';

class MoviePhotosPage extends StatefulWidget {
  final String title;
  final String type;
  final String id;

  MoviePhotosPage(this.title, this.type, this.id);

  @override
  createState() => _MoviePhotosPageState();
}

class _MoviePhotosPageState extends State<MoviePhotosPage> {
  List<Photos> photos = [];
  List<String> images = [];

  int page = 1;
  int pageSize = 20;

  bool isFirst = true;

  bool isLoadComplete = false;

  @override
  void initState() {
    super.initState();

    getPhotosList(widget.type, widget.id, page, RefreshType.DEFAULT);
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

  void getPhotosList(
      String url, String id, int page, RefreshType loadDataType) async {
    List<Photos> _photos =
        await ApiService.getPhotos(url, id, page: page, limit: pageSize);

    if (_photos.length < pageSize) {
      Toast.show(context, '数据加载完成...');
      isLoadComplete = true;
    }

    photos.addAll(_photos);
    _photos.forEach((f) {
      images.add(f.image);
    });

    if (isFirst) {
      isFirst = false;
    }
    if (mounted) setState(() {});
  }

  Widget _buildBodyView() {
    if (isFirst && photos.isEmpty) {
      return LoadingWidget();
    }
    return EasyRefresh(
        footer: BallPulseFooter(),
        onLoad: isLoadComplete
            ? null
            : () async {
                page++;
                getPhotosList(
                    widget.type, widget.id, page, RefreshType.LOAD_MORE);
              },
        child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: photos?.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => ItemPhoto(photos[index],
                onTap: () => pushNewPage(
                    context,
                    PhotoView(
                      title: widget.title,
                      photos: images,
                      index: index,
                      heroTag: photos[index]?.id,
                    ))),
            staggeredTileBuilder: (index) => StaggeredTile.fit(2)),
        emptyWidget: photos.isEmpty ? EmptyPage(text: "没有数据！") : null);
  }
}
