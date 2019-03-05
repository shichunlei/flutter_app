import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class QrImageWidget extends StatefulWidget {
  @override
  QrImageWidgetState createState() => QrImageWidgetState();
}

class QrImageWidgetState extends State<QrImageWidget> {
  String result = "Hey there !";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('生成二维码'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(25.0),
              child: QrImage(
                  backgroundColor: Colors.purpleAccent,
                  data: result,
                  gapless: false,
                  foregroundColor: const Color(0xFF001111),
                  onError: (dynamic ex) => setState(() =>
                      result = 'Error! Maybe your input value is too long?'))),
          Text(result,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error";
      });
    }
  }
}
