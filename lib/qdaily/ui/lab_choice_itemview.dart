import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

import '../index.dart';

class LabChoiceItemView extends StatefulWidget {
  final Question question;
  final Function onTap;

  LabChoiceItemView({Key key, @required this.question, this.onTap})
      : super(key: key);

  @override
  createState() => _LabChoiceItemViewState();
}

class _LabChoiceItemViewState extends State<LabChoiceItemView>
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
        Visibility(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ImageLoadView('${widget.question?.image}',
                width: Utils.width - 20,
                height: (Utils.width - 20) * 412 / 700),
          ),
          visible: widget.question.image != "",
        ),
        Expanded(
          child: GridView.builder(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: widget.question.image != "" ? 2.0 : 0.9,
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5),
              itemBuilder: (context, index) {
                return Material(
                  color: Colors.white,
                  child: InkWell(
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Visibility(
                                child: Expanded(
                                  child: ImageLoadView(
                                    '${widget.question?.options[index]?.optionPicUrl}',
                                    width: double.infinity,
                                  ),
                                ),
                                visible: widget.question.image == "",
                              ),
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                      '${widget.question?.options[index]?.title}'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() => widget.onTap(true));
                      }),
                );
              },
              itemCount: widget.question?.options?.length ?? 0),
        )
      ],
    );
  }
}
