import 'package:flutter/material.dart';
import 'package:flutter_app/ui/image_load_view.dart';

import '../index.dart';

class ItemOptionCheckbox extends StatefulWidget {
  final Option option;
  final Function onChecked;
  final bool isChecked;

  ItemOptionCheckbox(
      {Key key, @required this.option, this.onChecked, this.isChecked: false})
      : super(key: key);

  @override
  createState() => _ItemOptionCheckboxState();
}

class _ItemOptionCheckboxState extends State<ItemOptionCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
          onTap: () => setState(() => widget.onChecked(!widget.isChecked)),
          child: Container(
            child: Row(
              children: <Widget>[
                ImageLoadView('${widget.option?.image}',
                    width: 90, height: 90),
                SizedBox(width: 10),
                Expanded(child: Text('${widget.option?.content}')),
                Checkbox(
                    value: widget.isChecked,
                    onChanged: (checked) =>
                        setState(() => widget.onChecked(checked)))
              ],
            ),
          ),
        ),
        color: Colors.white);
  }
}
