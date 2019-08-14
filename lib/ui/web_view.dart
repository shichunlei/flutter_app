import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/global/custom_icon.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage({@required this.url, this.title});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  FlutterWebviewPlugin flutterWebviewPlugin;

  bool showLoading = false;

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin = FlutterWebviewPlugin();

    /// initialChild只有第一网页加载时会显示，网页内部页面跳转不会再显示，所以要手动加上页面内跳转监听
    flutterWebviewPlugin.onStateChanged.listen((state) {
      debugPrint('_WebViewPageState.initState  state = ${state.type}');
      if (state.type == WebViewState.shouldStart) {
        setState(() {
          showLoading = true;
        });
      } else if (state.type == WebViewState.finishLoad ||
          state.type == WebViewState.abortLoad) {
        setState(() {
          showLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: this.widget.url,
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title ?? ''),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Share.share(this.widget.url);
            },
            icon: Icon(CustomIcon.share4, color: Colors.white),
          ),
        ],
        bottom: PreferredSize(
          child: showLoading
              ? LinearProgressIndicator(backgroundColor: Colors.grey)
              : Container(),
          preferredSize: Size(double.infinity, 1),
        ),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild:
          Container(child: const Center(child: CupertinoActivityIndicator())),
    );
  }
}
