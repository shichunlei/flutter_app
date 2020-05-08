import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/res/styles.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_flutter/barcode_flutter.dart';

class QRCodePage extends StatefulWidget {
  QRCodePage({Key key}) : super(key: key);

  @override
  createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String qrResult = 'https://baidu.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 19, 71, 255),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text('Payment'),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.crop_free), onPressed: _scanQR)
            ]),
        body: Column(children: <Widget>[
          Expanded(
              child: Card(
                  margin: EdgeInsets.only(top: 10.0, left: 20, right: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  color: Color.fromARGB(255, 252, 251, 252),
                  child: Column(children: <Widget>[
                    //top info
                    Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 30,
                                  offset: Offset(0, 20))
                            ]),
                        child: Row(children: <Widget>[
                          Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                Text("136ae**347",
                                    style: TextStyle(
                                        fontSize: 28,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w700)),
                                Gaps.vGap10,
                                Text("Scan tow-dimensional code payment.",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey))
                              ])),
                          Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 19, 71, 255),
                                  shape: BoxShape.circle),
                              child: Container(
                                  height: 27,
                                  width: 27,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Text("支",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromARGB(
                                              255, 19, 71, 255)))))
                        ])),
                    Expanded(
                        child: QrImage(
                            padding: EdgeInsets.all(20.0),
                            data: qrResult,
                            foregroundColor: Color.fromARGB(255, 80, 93, 124),
                            embeddedImage:
                                AssetImage('images/flutter_logo.png'),
                            embeddedImageStyle:
                                QrEmbeddedImageStyle(size: Size(60, 60)))),
                    //BarCode
                    Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Opacity(
                            opacity: 0.5,
                            child: BarCodeImage(
                                foregroundColor:
                                    Color.fromARGB(255, 80, 93, 124),
                                params: Code128BarCodeParams("2690123456789",
                                    withText: true,
                                    lineWidth: 1.4,
                                    barHeight: 70.0),
                                padding: EdgeInsets.all(10.0),
                                // Render with text label or not (default: false)
                                onError: (error) {
                                  // Error handler
                                  debugPrint('error = $error');
                                })))
                  ]))),
          //Bottom text
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Password Payment",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                    Gaps.hGap24,
                    IconButton(
                        icon: Icon(Icons.arrow_forward,
                            color: Colors.white, size: 30),
                        onPressed: () {})
                  ]))
        ]));
  }

  Future _scanQR() async {
    try {
      qrResult = await BarcodeScanner.scan();
      debugPrint("==================$qrResult");
      setState(() {});
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }
}
