import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  @override
  AboutUsPageState createState() => AboutUsPageState();
}

class AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: bulderBodyContent(),
      ),
    );
  }

  List<Widget> bulderBodyContent() {
    List<Widget> widgets = [];
    var hearderView = Container(
      height: 200.0,
      child: Image.network(
        "http://pic33.photophoto.cn/20141028/0038038006886895_b.jpg",
        fit: BoxFit.cover,
      ),
    );

    var rowView = Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Oeschinen Lake Campground",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                ),
                SizedBox(height: 10.0),
                Text(
                  "Kandersteg, Switzerland",
                  style: TextStyle(color: Colors.black26),
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red,
          ),
          Text("41"),
        ],
      ),
    );

    var iconsView = Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
                SizedBox(height: 10.0),
                Text(
                  "CALL",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.router,
                  color: Colors.blue,
                ),
                SizedBox(height: 10.0),
                Text(
                  "ROUTER",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.share,
                  color: Colors.blue,
                ),
                SizedBox(height: 10.0),
                Text(
                  "SHARE",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

    var textView = Padding(
      padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
      child: Text(
          "Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run."),
    );

    widgets..add(hearderView)..add(rowView)..add(iconsView)..add(textView);

    return widgets;
  }
}
