import 'package:flutter/material.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:multi_image_picker/asset.dart';

class AssetView extends StatefulWidget {
  final int index;
  final Asset asset;
  final VoidCallback onTap;
  final bool showAdd;

  AssetView(
      {Key key,
      this.index,
      @required this.asset,
      this.onTap,
      this.showAdd = false})
      : super(key: key);

  @override
  createState() => _AssetState();
}

class _AssetState extends State<AssetView> {
  @override
  void initState() {
    super.initState();
    if (!widget.showAdd) _loadImage();
  }

  void _loadImage() async {
    await widget.asset.requestThumbnail(300, 300, quality: 50);

    if (this.mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showAdd) {
      return GestureDetector(
        child: Image.asset('images/add_image.png', fit: BoxFit.cover),
        onTap: widget.onTap,
      );
    }
    if (null != widget.asset.thumbData) {
      return GestureDetector(
        child: Image.memory(
          widget.asset.thumbData.buffer.asUint8List(),
          fit: BoxFit.cover,
          gaplessPlayback: true,
        ),
        onTap: widget.onTap,
      );
    }

    return getLoadingWidget();
  }
}
