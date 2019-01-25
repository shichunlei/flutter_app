import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_app/utils/loading_util.dart';

class ShiciPage extends StatefulWidget {
  @override
  ShiciPageState createState() => ShiciPageState();
}

class ShiciPageState extends State<ShiciPage> {
  ShiciInfo _shiciInfo;

  String title = "";
  String content = "";
  String authors = "";

  bool isShowLoading = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('随机诗词'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  showLoadingDialog(context, "正在加载...");
                  isShowLoading = true;
                  getData();
                },
                tooltip: "刷新"),
          ],
          backgroundColor: Colors.redAccent,
        ),
        body: Stack(
          children: <Widget>[
            Offstage(
                offstage: _shiciInfo != null,
                child: Center(child: getLoadingWidget())),
            Offstage(
                offstage: _shiciInfo == null,
                child: SingleChildScrollView(
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                      SizedBox(height: 20.0),
                      Text(title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20.0)),
                      SizedBox(height: 20.0),
                      Text(authors),
                      Container(
                          child: Text(content), margin: EdgeInsets.all(20.0))
                    ]))))
          ],
        ));
  }

  getData() async {
    var httpClient = HttpClient();
    var url = "https://api.apiopen.top/recommendPoetry";
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonData = await response.transform(utf8.decoder).join();

      if (isShowLoading) {
        Navigator.of(context).pop();
        isShowLoading = false;
      }
      setState(() {
        _shiciInfo = ShiciInfo.decodeData(jsonData);
        title = _shiciInfo.title;
        content = _shiciInfo.content;
        authors = _shiciInfo.authors;
      });
    }
  }
}

class ShiciInfo {
  String title;
  String content;
  String authors;

  ShiciInfo({this.title, this.content, this.authors});

  static ShiciInfo decodeData(String jsonData) {
    var data = json.decode(jsonData);
    if (data['code'] == 200) {
      return fromMap(data['result']);
    } else {
      return null;
    }
  }

  static ShiciInfo fromMap(data) {
    print(data);
    String content = "";

    List con = data['content'].split('|');
    for (int i = 0; i < con.length; i++) {
      content += con[i].toString() + "\n\n";
    }
    return ShiciInfo(
      title: data['title'],
      content: content.toString(),
      authors: data['authors'],
    );
  }
}
