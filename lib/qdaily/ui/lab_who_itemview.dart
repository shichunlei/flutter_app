import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class LabWhoItemView extends StatefulWidget {
  final Question question;
  final int index;
  final Function(bool, int) callBack;

  LabWhoItemView({
    Key key,
    this.question,
    this.index,
    this.callBack,
  }) : super(key: key);

  @override
  createState() => _LabWhoItemViewState();
}

class _LabWhoItemViewState extends State<LabWhoItemView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(children: <Widget>[
        Text('${widget.question?.content}',
            style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
        SizedBox(height: 10),
        ImageLoadView('${widget.question?.image}',
            width: Utils.width - 20, height: (Utils.width - 20) * 412 / 700),
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2,
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5),
            itemBuilder: (_, index) {
              return Material(
                color: Colors.white,
                child: InkWell(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text('${widget.question?.options[index]?.title}'),
                      alignment: Alignment.center,
                    ),
                    onTap: () {
                      setState(() {
                        widget.callBack(true, widget.index);
                      });
                    }),
              );
            },
            itemCount: widget.question?.options?.length ?? 0,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: false)
      ]),
    );
  }
}
