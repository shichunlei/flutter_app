import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/toast/toast.dart';
import 'package:flutter_app/poetry/poetry.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/loading_util.dart';

class RandomPoetryPage extends StatefulWidget {
  @override
  createState() => _RandomPoetryPageState();
}

class _RandomPoetryPageState extends State<RandomPoetryPage> {
  String title = "";
  String content = "";
  String authors = "";

  bool isShowLoading = false;

  Result poetryResult;

  @override
  void initState() {
    super.initState();

    getRandomPoetry();
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
                getRandomPoetry();
              },
              tooltip: "刷新"),
        ],
        backgroundColor: Colors.redAccent,
      ),
      body: Stack(
        children: <Widget>[
          Offstage(
              offstage: poetryResult != null,
              child: Center(child: getLoadingWidget())),
          Offstage(
            offstage: poetryResult == null,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20.0),
                      ),
                    ),
                    Label(
                      triangleHeight: 10.0,
                      edge: Edge.RIGHT,
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 18.0, top: 8.0, bottom: 8.0),
                          color: Colors.green,
                          child: Text(
                            authors,
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    Message(
                      triangleX1: 80.0,
                      triangleX2: 100.0,
                      triangleX3: 80.0,
                      triangleY1: 60.0,
                      child: Container(
                          padding: const EdgeInsets.all(20.0),
                          color: Colors.teal,
                          child: Text(
                            content,
                            style: TextStyle(color: Colors.white),
                          ),
                          margin: EdgeInsets.all(20.0)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getRandomPoetry() async {
    Response response =
        await HttpUtils().get('https://api.apiopen.top/recommendPoetry');

    if (response.statusCode == 200) {
      var jsonData = response.data;
      Poetry poetry = Poetry.fromMap(jsonData);

      if (poetry.code == 200) {
        poetryResult = poetry.result;
      } else {
        Toast.show('请求失败', context);
      }
    }

    if (isShowLoading) {
      Navigator.of(context).pop();
      isShowLoading = false;
    }

    title = poetryResult.title;
    content = poetryResult.content;
    authors = poetryResult.authors;

    setState(() {});
  }
}
