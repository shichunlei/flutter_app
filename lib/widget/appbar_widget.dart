import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('渐变颜色的appBar'),

        /// 可以用这种方式设置渐变的AppBar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.cyan,
                Colors.blue,
                Colors.blueAccent,
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          /// App bar with background color
          Container(
            child: AppBar(
              title: Text("Title"),
              backgroundColor: Colors.orange,
              elevation: 4.0,
            ),
            margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
          ),

          /// App bar with Action items
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: AppBar(
              title: Text("Appbar actions"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          /// Center text
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: AppBar(
              title: Text("Center"),
              centerTitle: true,
            ),
          ),

          /// IconTheme for the app bar
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: AppBar(
              title: Text("Appbar Icon and Text Theme"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(FeatherIcons.settings, color: Colors.white),
                  onPressed: () {},
                ),
              ],
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              textTheme: TextTheme(
                title: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),

          /// App bar with the title and subtitle
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Title",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "subtitle",
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),

          /// App bar with the title and and icon/image at start
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: AppBar(
              backgroundColor: Colors.orangeAccent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  FlutterLogo(),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Title with image",
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// App Bar with transparent background
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              title: Text("Transparent AppBar"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: AppBar(
              title: Text('AppBar leading'),
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(FeatherIcons.chevronLeft),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
