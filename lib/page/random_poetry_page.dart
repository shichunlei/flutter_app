import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/poetry.dart';
import 'package:flutter_app/service/api_service.dart';
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

  Poetry poetry;

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
      body: _buildBodyView(),
    );
  }

  Widget _buildBodyView() {
    if (null == poetry) {
      return getLoadingWidget();
    }
    return SingleChildScrollView(
      child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
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
          alignment: Alignment.topCenter),
    );
  }

  void getRandomPoetry() async {
    poetry = await ApiService.getRecommendPoetry();

    if (isShowLoading) {
      Navigator.of(context).pop();
      isShowLoading = false;
    }

    title = poetry.title;
    content = poetry.content;
    authors = poetry.authors;

    setState(() {});
  }
}
