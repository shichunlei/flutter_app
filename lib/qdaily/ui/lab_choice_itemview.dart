import 'package:flutter/material.dart';
import 'package:flutter_app/bean/qdaily_app.dart';
import 'package:flutter_app/page_index.dart';

class ItemLabPageView extends StatefulWidget {
  final Question question;
  final Function onTap;

  ItemLabPageView({Key key, @required this.question, this.onTap})
      : super(key: key);

  @override
  createState() => _ItemLabPageViewState();
}

class _ItemLabPageViewState extends State<ItemLabPageView>
    with SingleTickerProviderStateMixin {
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
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text('${widget.question?.content}',
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center)),
        Expanded(
          child: GridView.builder(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.9,
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5),
              itemBuilder: (context, index) {
                return Material(
//                  color: Colors.white,
                  child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: ImageLoadView(
                              '${widget.question?.options[index]?.optionPicUrl}',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                                '${widget.question?.options[index]?.title}'),
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          widget.onTap(true);
                        });
                      }),
                );
              },
              itemCount: widget.question?.options?.length ?? 0),
        )
      ],
    );
  }
}
