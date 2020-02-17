import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

class ScanViewPage extends StatefulWidget {
  @override
  _ScanViewPageState createState() => _ScanViewPageState();
}

class _ScanViewPageState extends State<ScanViewPage> {
  List<String> items = [];
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future _scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      if (barcode != null || barcode != "") {
        if (!items.contains(barcode)) {
          items.add(barcode);
        }
      }
      setState(() {});
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择报关单'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            /// 扫一扫
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('扫一扫'),
                  IconButton(
                    icon: Icon(
                      Icons.crop_free,
                      color: Colors.lightBlue,
                      size: 40,
                    ),
                    onPressed: _scan,
                  )
                ],
              ),
            ),

            Container(
              height: 1,
              color: Colors.grey,
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
            ),

            /// 输出报关单号
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 15.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: '请输出报关单号'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.lightBlue, size: 40),
                    onPressed: () {
                      if (_controller.text != null && _controller.text != "") {
                        /// 判断数组里是否存在
                        if (!items.contains(_controller.text)) {
                          items.add(_controller.text);
                        }

                        /// 添加完毕清空输入框
                        _controller.text = "";
                      }

                      setState(() {});
                    },
                  )
                ],
              ),
            ),

            Container(
              height: 1,
              color: Colors.grey,
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
            ),

            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(15.0, 5, 15.0, 0),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('${items[index]}'),
                    trailing: Icon(Icons.clear),
                    onTap: () {
                      items.removeAt(index);

                      /// remove后刷新列表
                      setState(() {});
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return index % 2 == 0
                      ? Divider(color: Colors.red)
                      : Divider(color: Colors.orange);
                },
                //itemCount: items.length,
                itemCount: items.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
