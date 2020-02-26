import 'package:flutter/material.dart';

import 'widgets/card_gridview.dart';
import 'widgets/card_one.dart';
import 'widgets/card_top.dart';

class PostDetailsPage extends StatefulWidget {
  final int index;

  PostDetailsPage({Key key, this.index = 1}) : super(key: key);

  @override
  createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(brightness: Brightness.light, primaryColor: Colors.white),
      child: Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.index == 1 ? CardOne() : CardGridView(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 20),
                child: Text(
                  'Comments(5)',
                  style: TextStyle(color: Color(0xFF00010F)),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.only(top: 10),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: [
                        CardTop(radius: 15),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 30, right: 20),
                          child: Text(
                            'This is her pregnancy announcement, Y`all know Bey sneaky af.',
                            style: TextStyle(
                                color: Color(0xFF313131), fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 20, top: 8, bottom: 8),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                'images/thumbUp.png',
                                width: 18,
                              ),
                              SizedBox(width: 20),
                              Image.asset(
                                'images/thumbDown.png',
                                width: 18,
                              ),
                              SizedBox(width: 20),
                              Row(
                                children: <Widget>[
                                  Image.asset('images/comment.png'),
                                  SizedBox(width: 5),
                                  Text(
                                    '5',
                                    style: TextStyle(
                                      color: Color(0xFF5A5A5A),
                                    ),
                                  )
                                ],
                                mainAxisSize: MainAxisSize.min,
                              ),
                              Spacer(),
                              Text(
                                'VIEW REPLY',
                                style: TextStyle(color: Color(0xFF32C5FF)),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                            padding: EdgeInsets.only(left: 30.0, right: 20),
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (_, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Color(0xFFF7F7F7)),
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 13,
                                      backgroundImage: NetworkImage(
                                          'http://b-ssl.duitang.com/uploads/item/201705/18/20170518154132_mEGnZ.thumb.224_0.jpeg'),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: RichText(
                                          text: TextSpan(
                                              text: 'hatayeaed',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.black),
                                              children: <TextSpan>[
                                            TextSpan(
                                              text: ' Good Have a nice day.',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black26,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ])),
                                    ),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              );
                            },
                            separatorBuilder: (_, index) {
                              return SizedBox(height: 3);
                            },
                            itemCount: 2)
                      ],
                    ),
                  );
                },
                itemCount: 3,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
