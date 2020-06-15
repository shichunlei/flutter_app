import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class LoadImageWidget extends StatefulWidget {
  @override
  createState() => LoadImageWidgetState();
}

class LoadImageWidgetState extends State<LoadImageWidget> {
  Future<File> _imageFile;
  bool isVideo = false;
  VideoPlayerController _controller;
  VoidCallback listener;

  void _onImageButtonPressed(ImageSource source) async {
    if (isVideo) {
      if (_controller != null) {
        _controller.removeListener(listener);
      }
      File videoFile = await ImagePicker.pickVideo(source: source);
      if (videoFile != null && mounted) {
        String videoFilePath = videoFile.path;

        // 视频地址
        debugPrint("视频地址==========:$videoFilePath");

        String filename = videoFilePath.substring(
            videoFilePath.lastIndexOf("/") + 1, videoFilePath.length);
        debugPrint(filename);

        String videoFolderPath =
            videoFilePath.substring(0, videoFilePath.lastIndexOf("/") + 1);

        String newPath = await FileUtil.getInstance().getLocalPath() + "/";

        String path = await FileUtil.getInstance()
            .copyFile(filename, videoFolderPath, newPath);

        debugPrint("path====$path");

        _controller = VideoPlayerController.file(videoFile)
          ..addListener(listener)
          ..initialize().then((_) {
            _controller..setLooping(true);
            setState(() {});
          });
      }
    } else {
      _imageFile = ImagePicker.pickImage(source: source);
    }

    setState(() {});
  }

  @override
  void deactivate() {
    _controller?.removeListener(listener);
    super.deactivate();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    listener = () {};
  }

  Widget _previewVideo() {
    if (_controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    } else if (_controller.value.initialized) {
      return Container(
        child: GestureDetector(
          onTap: () {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          },
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio, // 按照视频比例展示视频
            child: VideoPlayer(_controller),
          ),
        ),
      );
    } else {
      return const Text(
        'Error Loading Video',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _previewImage() {
    return FutureBuilder<File>(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Image.file(snapshot.data);
          } else if (snapshot.error != null) {
            return const Text(
              'Error picking image.',
              textAlign: TextAlign.center,
            );
          } else {
            return const Text(
              'You have not yet picked an image.',
              textAlign: TextAlign.center,
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Or Video Picker"),
      ),
      body: Center(
        child: isVideo ? _previewVideo() : _previewImage(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              isVideo = false;
              _onImageButtonPressed(ImageSource.gallery);
            },
            heroTag: 'image0',
            tooltip: 'Pick Image from gallery',
            child: const Icon(Icons.photo_library),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onImageButtonPressed(ImageSource.camera);
              },
              heroTag: 'image1',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                isVideo = true;
                _onImageButtonPressed(ImageSource.gallery);
              },
              heroTag: 'video0',
              tooltip: 'Pick Video from gallery',
              child: const Icon(Icons.video_library),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                isVideo = true;
                _onImageButtonPressed(ImageSource.camera);
              },
              heroTag: 'video1',
              tooltip: 'Take a Video',
              child: const Icon(Icons.videocam),
            ),
          ),
        ],
      ),
    );
  }
}
