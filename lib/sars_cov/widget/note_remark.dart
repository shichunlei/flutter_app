import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';

import 'title_container.dart';

class NoteRemarkView extends StatelessWidget {
  final SARSCov data;

  NoteRemarkView({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      TitleContainer(title: "疫情介绍"),
      Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                    text: TextSpan(
                        text: '${data?.note1?.first.toString()}：',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.red),
                        children: <TextSpan>[
                      TextSpan(
                          text: data == null
                              ? ""
                              : '${data?.note1[1].toString()}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal))
                    ])),
                RichText(
                    text: TextSpan(
                        text: '${data?.note2?.first.toString()}：',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange),
                        children: <TextSpan>[
                      TextSpan(
                          text: data == null
                              ? ""
                              : '${data?.note2[1].toString()}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal))
                    ])),
                RichText(
                    text: TextSpan(
                        text: '${data?.note3?.first.toString()}：',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.purple),
                        children: <TextSpan>[
                      TextSpan(
                          text: data == null
                              ? ""
                              : '${data?.note3[1].toString()}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal))
                    ])),
                RichText(
                    text: TextSpan(
                        text: '${data?.remark1?.first.toString()}：',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.green),
                        children: <TextSpan>[
                      TextSpan(
                          text: data == null
                              ? ""
                              : '${data?.remark1[1].toString()}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal))
                    ])),
                RichText(
                    text: TextSpan(
                        text: '${data?.remark2?.first.toString()}：',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.cyan),
                        children: <TextSpan>[
                      TextSpan(
                          text: data == null
                              ? ""
                              : '${data?.remark2[1].toString()}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal))
                    ])),
                RichText(
                    text: TextSpan(
                        text: '${data?.remark3?.first.toString()}：',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.pink),
                        children: <TextSpan>[
                      TextSpan(
                          text: data == null
                              ? ""
                              : '${data?.remark3[1].toString()}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal))
                    ]))
              ]))
    ]));
  }
}
