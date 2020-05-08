import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

class FontLoaderPage extends StatefulWidget {
  FontLoaderPage({Key key}) : super(key: key);

  @override
  createState() => _FontLoaderPageState();
}

class _FontLoaderPageState extends State<FontLoaderPage> {
  String downloadProgress = "0.0";
  bool complete = false;

  String savePath = '';
  String fontPath = '';

  CancelToken _cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    savePath = await FileUtil.getInstance().getFolderPath("fontDownloadDemo");

    fontPath = "$savePath/Montserrat-Light.ttf";

    if (await FileUtil.getInstance().fileExists(fontPath)) {
      downloadProgress = '1234567890abcdefghijklmnopqrstuvwxyz';
      complete = true;
      await Utils.readFont("Montserrat-Light", fontPath);

      setState(() {});
    }
  }

  @override
  void dispose() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('动态加载外部字体')),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text('download Progress:'),
              Text(downloadProgress,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: complete ? 'Montserrat-Light' : null,
                      fontWeight: FontWeight.bold,
                      color: Colors.red))
            ])),
        floatingActionButton: FloatingActionButton(
            onPressed: complete ? null : downloadFont, child: Icon(Icons.add)));
  }

  void downloadFont() async {
    String url =
        'https://raw.githubusercontent.com/google/fonts/master/ofl/montserrat/Montserrat-Light.ttf';

    await HttpUtils().download(url, fontPath,
        onReceiveProgress: (count, total) {
      checkProgress(count / total);
    }, cancelToken: _cancelToken);
  }

  void checkProgress(double progress) async {
    downloadProgress = '${(progress * 100).toStringAsFixed(0)} %';

    if (progress == 1) {
      complete = true;
      downloadProgress = 'success';
      await Utils.readFont("Montserrat-Light", fontPath);
    }

    setState(() {});
  }
}
