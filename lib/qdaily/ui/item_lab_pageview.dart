import 'package:flutter/material.dart';
import 'package:flutter_app/bean/qdaily_app.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/utils/utils.dart';

class ItemLabPageView extends StatefulWidget {
  final Question question;
  final VoidCallback onTap;

  ItemLabPageView({Key key, @required this.question, this.onTap})
      : super(key: key);

  @override
  createState() => _ItemLabPageViewState();
}

class _ItemLabPageViewState extends State<ItemLabPageView> {
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
        Text('${widget.question.title}',
            style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
        SizedBox(height: 10),
        ImageLoadView('${widget.question.image}',
            width: Utils.width - 20, height: (Utils.width - 20) * 412 / 700),
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2,
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5),
            itemBuilder: (context, index) {
              return InkWell(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text('${widget.question.options[index].content}'),
                      alignment: Alignment.center,
                      color: Colors.white),
                  onTap: widget.onTap);
            },
            itemCount: widget.question.options.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: false)
      ]),
    );
  }
}
