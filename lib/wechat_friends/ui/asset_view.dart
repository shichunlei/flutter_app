import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AssetView extends StatelessWidget {
  final Asset asset;
  final VoidCallback onTap;

  AssetView({Key key, this.asset, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (null != asset) {
      debugPrint('${asset.name}===============${asset.identifier}');
    }

    return GestureDetector(
      child: null != asset
          ? AssetThumb(asset: asset, width: 300, height: 300)
          : Image.asset('images/add_image.png', fit: BoxFit.cover),
      onTap: onTap,
    );
  }
}
