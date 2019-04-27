import 'package:flutter/material.dart';

class CartAmountView extends StatelessWidget {
  final int amount;
  final VoidCallback addOnPressed;
  final VoidCallback minusOnPressed;

  CartAmountView(
      {Key key, this.addOnPressed, this.minusOnPressed, this.amount = 1})
      : assert(amount != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
              child: Icon(Icons.remove,
                  size: 25, color: amount > 1 ? Colors.black : Colors.grey),
              onTap: minusOnPressed),
          Container(width: 1.0, color: Colors.grey, height: 25),
          Container(
              child: Text(' $amount '),
              width: 35.0,
              alignment: Alignment.center),
          Container(width: 1.0, color: Colors.grey, height: 25),
          GestureDetector(child: Icon(Icons.add, size: 25), onTap: addOnPressed)
        ],
      ),
    );
  }
}
