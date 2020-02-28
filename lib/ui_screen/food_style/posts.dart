import 'package:flutter/material.dart';
import 'post_details.dart';

import 'widgets/card_gridview.dart';
import 'widgets/card_one.dart';

class PostsPage extends StatefulWidget {
  PostsPage({Key key}) : super(key: key);

  @override
  createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(brightness: Brightness.light, primaryColor: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Posts'),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'NEW',
                    child: Row(
                      children: <Widget>[
                        Image.asset('images/write.png'),
                        SizedBox(width: 5),
                        Text('New Posts'),
                      ],
                      mainAxisSize: MainAxisSize.min,
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'MY',
                    child: Row(
                      children: <Widget>[
                        Image.asset('images/myfeed.png'),
                        SizedBox(width: 5),
                        Text('My Posts'),
                      ],
                      mainAxisSize: MainAxisSize.min,
                    ),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == "NEW") {
                } else if (value == "MY") {}
              },
            )
          ],
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Container(
                  height: 40,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset('images/msg.png'),
                                  SizedBox(width: 5),
                                  Text(
                                    'Messages',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset('images/followings.png'),
                                SizedBox(width: 5),
                                Text(
                                  'Followings',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                      Expanded(
                          child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset('images/fans.png'),
                                SizedBox(width: 5),
                                Text(
                                  'Fans',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child: Text(
                  'Unread',
                  style: TextStyle(color: Color(0xFF363D49), fontSize: 18),
                ),
              ),
              ListView(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.only(left: 30, right: 30),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                      ),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                                'http://image.biaobaiju.com/uploads/20180802/02/1533149709-PxGDfHIeCw.jpeg'),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Toy',
                            style: TextStyle(
                                color: Color(0xFF595959),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Shall we catch up today? If not, let us',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 4,
                        bottom: 8,
                      ),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                                'http://b-ssl.duitang.com/uploads/item/201804/24/20180424135801_ivcho.jpg'),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Anna Fali',
                            style: TextStyle(
                                color: Color(0xFF595959),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Shall we catch up today? If not, let us',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
              ListView(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.zero,
                children: <Widget>[
                  CardOne(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetailsPage(index: 1),
                          ));
                    },
                  ),
                  CardGridView(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetailsPage(index: 2),
                          ));
                    },
                  ),
                  CardOne(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetailsPage(index: 1),
                          ));
                    },
                  ),
                  CardGridView(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetailsPage(index: 2),
                          ));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
