import 'package:flutter/material.dart';
import 'package:flutter_app/bean/image.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BottomGridView extends StatefulWidget {
  final int index;
  final String title;

  BottomGridView({Key key, this.index, this.title}) : super(key: key);

  @override
  createState() => BottomGridViewState();
}

class BottomGridViewState extends State<BottomGridView> {
  List<ImageModal> images = [];

  @override
  void initState() {
    super.initState();
    getListData(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    double itemWidth = Utils.width / 2 - 4;

    return images.isEmpty
        ? Center()
        : StaggeredGridView.countBuilder(
            shrinkWrap: true,
            primary: false,
            crossAxisCount: 4,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            itemBuilder: (context, index) => ImageLoadView(
                  images[index].thumb,
                  width: itemWidth,
                  height:
                      itemWidth * images[index].height / images[index].width,
                ),
            staggeredTileBuilder: (index) => StaggeredTile.fit(2),
            itemCount: images.length);
  }

  void getListData(String key) async {
    images = [];
    images = await ApiService.getImagesData(key);

    setState(() {});
  }
}
