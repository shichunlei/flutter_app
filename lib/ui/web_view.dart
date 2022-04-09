import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page_index.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage({@required this.url, this.title});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool showLoading = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0, title: Text(widget.title ?? ''), actions: <Widget>[
          IconButton(
              onPressed: () {
                Share.share(this.widget.url);
              },
              icon: Icon(CustomIcon.share4, color: Colors.white))
        ]),
        body: Stack(children: [
          Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              child: WebView(
                  initialUrl: widget.url,
                  onPageFinished: (String url) {
                    setState(() {
                      showLoading = false;
                    });
                  },
                  onPageStarted: (String url) {
                    setState(() {
                      showLoading = true;
                    });
                  })),
          Visibility(visible: showLoading, child: Container(child: const Center(child: CupertinoActivityIndicator())))
        ]));
  }
}
