import 'package:flutter/material.dart';
import 'package:flutter_app/bean/qdaily_app.dart';
import 'package:flutter_app/ui/image_load_view.dart';

class ItemOptionCheckbox extends StatefulWidget {
  final Option option;

  ItemOptionCheckbox({Key key, @required this.option}) : super(key: key);

  @override
  createState() => _ItemOptionCheckboxState();
}

class _ItemOptionCheckboxState extends State<ItemOptionCheckbox> {
  var _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 10),
        margin: EdgeInsets.only(top: 20),
        height: 90,
        child: Row(children: <Widget>[
          ImageLoadView('${widget.option?.image}', width: 90, height: 90),
          SizedBox(width: 10),
          Expanded(child: Text('${widget.option?.content}')),
          Checkbox(
              value: _isChecked,
              activeColor:Color(0xFFFFD003),
              checkColor: Colors.red,
              onChanged: (checked) {
                setState(() {
                  _isChecked = checked;
                });
              })
        ]),
        color: Color(0xFFF2F2F2));
  }
}
