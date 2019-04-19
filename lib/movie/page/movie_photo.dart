import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/bean/photos.dart';
import 'package:flutter_app/utils/log_util.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share/share.dart';

import 'package:image_picker_saver/image_picker_saver.dart';

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
                      imageProvider: NetworkImage(photo.cover),
                      heroTag: photo.id,
                    ))
                .toList(),
            backgroundDecoration: BoxDecoration(color: Colors.black),
            onPageChanged: (index) {
              setState(() => count = index + 1);
            },
            scrollPhysics: const BouncingScrollPhysics(),
            loadingChild: getLoadingWidget(),
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
          Align(
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: IconButton(
                highlightColor: Colors.white,
                splashColor: Colors.red,
                disabledColor: Colors.green,
                color: Colors.white,
                onPressed: () => _saveImage(widget.photos[count].image),
                icon: Icon(Icons.file_download),
              ),
            ),
            alignment: Alignment.bottomRight,
          ),
        ],
      ),
    );
  }

  void _saveImage(String imageUrl) async {
    LogUtil.v("_onImageSaveButtonPressed");
    Toast.show('正在保存...', context);

    var response = await http.get(imageUrl);

    var filePath =
        await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
    var savedFile = File.fromUri(Uri.file(filePath));
    Future<File>.sync(() => savedFile);
    Toast.show('保存成功', context);
  }
}
