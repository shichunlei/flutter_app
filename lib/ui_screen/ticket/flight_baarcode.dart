import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlightBarcode extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Opacity(
            opacity: 0.5,
            child: BarCodeImage(
              foregroundColor: Color.fromARGB(255, 80, 93, 124),
              params: Code39BarCodeParams(
                "2690123456789",
                withText: true,
                lineWidth: 1.4,
                barHeight: 50.0,
              ),
              padding: EdgeInsets.all(10.0),
              // Render with text label or not (default: false)
              onError: (error) {
                // Error handler
                print('error = $error');
              },
            )),
      ));
}
