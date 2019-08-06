import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AssetView extends StatefulWidget {
  final Asset asset;
  final VoidCallback onTap;

  AssetView({Key key, this.asset, this.onTap}) : super(key: key);

  @override
  createState() => _AssetState();
}

class _AssetState extends State<AssetView> {
  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    ByteData byteData =
        await widget.asset.requestThumbnail(300, 300, quality: 60);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (null != widget.asset) {
      debugPrint('${widget.asset.name}===============${widget.asset.identifier}');
    }

    return GestureDetector(
      child: null != widget.asset
          ? AssetThumb(asset: widget.asset, width: 300, height: 300)
          : Image.asset('images/add_image.png', fit: BoxFit.cover),
      onTap: widget.onTap,
    );
  }
}
