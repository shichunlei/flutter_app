import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class LabRatioPageView extends StatefulWidget {
  final List<Question> questions;
  final Function callBack;

  LabRatioPageView({Key key, this.questions, this.callBack}) : super(key: key);

  @override
  createState() => _LabRatioPageViewState();
}

class _LabRatioPageViewState extends State<LabRatioPageView>
    with TickerProviderStateMixin {
  PageController _controller;

  AnimationController animationController;
  Animation<int> animation1, animation2;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _controller = PageController(initialPage: currentPage);
  }

  @override
  void dispose() {
    _controller?.dispose();
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ChoiceNoView(
            index: currentPage + 1,
            total: widget.questions.length,
            padding: EdgeInsets.symmetric(vertical: 15)),
        Container(
          height: 325,
          child: PageView.builder(
            onPageChanged: (index) => setState(() {
              currentPage = index;
              widget.callBack(index + 1);
            }),
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            itemBuilder: (_, index) {
              animation1 = IntTween(
                      begin: 0,
                      end: widget.questions[index]?.options?.first?.percent)
                  .animate(animationController);
              animation2 = animationController.drive(IntTween(
                  begin: 0,
                  end:
                      widget.questions[index]?.options?.elementAt(1)?.percent));

              animationController.addListener(() => setState(() {}));

              return Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      '${widget.questions[index]?.content}',
                      style: TextStyles.textBoldDark16,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Material(
                                type: MaterialType.transparency,
                                child: InkWell(
                                    onTap: () => next(index),
                                    child: ImageLoadView(
                                        '${widget.questions[index]?.options?.first?.optionPicUrl}',
                                        sigmaX: 5.0,
                                        sigmaY: 6.0,
                                        opacity:
                                            animationController.value * 0.8,
                                        child: Text('${animation1.value}%',
                                            style: TextStyle(fontSize: 40))))),
                          ),
                          Gaps.hGap8,
                          Expanded(
                            child: Material(
                              type: MaterialType.transparency,
                              child: InkWell(
                                onTap: () => next(index),
                                child: ImageLoadView(
                                    '${widget.questions[index]?.options?.elementAt(1)?.optionPicUrl}',
                                    sigmaX: 5.0,
                                    sigmaY: 6.0,
                                    opacity: animationController.value * 0.8,
                                    child: Text('${animation2.value}%',
                                        style: TextStyle(fontSize: 40))),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
            itemCount: widget.questions.length,
          ),
        ),
      ],
    );
  }

  void next(int index) async {
    animationController.forward();

    if (widget.questions.length > index + 1) {
      Timer(Duration(milliseconds: 1500), () {
        _controller.animateToPage(index + 1,
            duration: Duration(milliseconds: 500), curve: Curves.decelerate);
        animationController.reset();
      });
    } else {}
  }
}
