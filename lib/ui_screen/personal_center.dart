import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class PersonalCenterPage extends StatefulWidget {
  PersonalCenterPage({Key key}) : super(key: key);

  @override
  createState() => _PersonalCenterPageState();
}

class _PersonalCenterPageState extends State<PersonalCenterPage> {
  double bannerHeight, radius, padding;

  @override
  void initState() {
    super.initState();

    bannerHeight = Utils.width * 9.0 / 16.0;

    radius = 45.0;

    padding = 8.0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: bannerHeight,
            child: Swiper(
              itemCount: 4,
              autoplay: true,
              itemBuilder: (_, index) => ImageLoadView(bannerImages[index]),
              pagination: SwiperCustomPagination(
                builder: (BuildContext context, SwiperPluginConfig config) =>
                    Container(
                        alignment: Alignment.bottomRight,
                        child: Container(
                            margin: EdgeInsets.only(bottom: 25, right: padding),
                            padding:
                                EdgeInsets.symmetric(
                                    horizontal: padding, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Color(0xAA423B5F)),
                            child: Text('${(config.activeIndex + 1)}/4',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13)))),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: radius + padding + 15),
            margin: EdgeInsets.only(top: bannerHeight - 15),
            decoration: const BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0,
                  )
                ]),
            width: Utils.width,
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Button(
                      child: Text(
                        'CONNECT',
                        style: const TextStyle(color: Colors.white),
                      ),
                      width: 110.0,
                      onPressed: () {},
                      height: 28,
                      color: Color(0xFF7E6BF0),
                      halfRadius: true,
                    ),
                    Button(
                      child: Text(
                        'FOLLOW',
                        style: const TextStyle(color: Colors.white),
                      ),
                      width: 110.0,
                      onPressed: () {},
                      height: 28,
                      color: Color(0xFF52A56A),
                      halfRadius: true,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        FontAwesome.venus,
                        color: Color(0xFFEC6657),
                        size: 15,
                      ),
                      Gaps.hGap8,
                      Text(
                        'Amily',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Gaps.hGap8,
                      Icon(
                        FontAwesome.edit,
                        color: Color(0xFF606060),
                        size: 15,
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: padding),
                  child: Text(
                    'It`s a beatifull day today',
                    style:
                        const TextStyle(fontSize: 12, color: Color(0xFF525252)),
                  ),
                ),
                Container(
                  width: 180,
                  height: 45,
                  child: RaisedButton(
                    onPressed: () {},
                    child: const Text(
                      'Message',
                      style: const TextStyle(color: Color(0xFF63B296)),
                    ),
                    shape: const StadiumBorder(),
                    elevation: 10.0,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: Utils.width,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Text(
                    'Information',
                    style: TextStyle(
                      color: Color(0xFF50A479),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Name:',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            flex: 1,
                          ),
                          Gaps.hGap20,
                          Expanded(
                            child: Text(
                              'Amily-3562',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF3D3D3D), fontSize: 16),
                            ),
                            flex: 3,
                          ),
                        ],
                      ),
                      Gaps.vGap10,
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Email:',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            flex: 1,
                          ),
                          Gaps.hGap20,
                          Expanded(
                            child: Text(
                              'amily-smiths@gmail.com',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF3D3D3D), fontSize: 16),
                            ),
                            flex: 3,
                          ),
                        ],
                      ),
                      Gaps.vGap10,
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Region:',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            flex: 1,
                          ),
                          Gaps.hGap20,
                          Expanded(
                            child: Text(
                              'Sydney,NSW,Australia',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF3D3D3D), fontSize: 16),
                            ),
                            flex: 3,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2918882617,1624283714&fm=26&gp=0.jpg'),
              radius: radius,
            ),
            top: bannerHeight - radius - 15,
            left: Utils.width / 2 - radius,
            right: Utils.width / 2 - radius,
          ),
          Positioned(
            child: Text(
              'ID:234390',
              style: TextStyle(fontSize: 18),
            ),
            left: Utils.width / 2.0 + radius + padding,
            right: padding,
            top: bannerHeight,
          ),
          Container(
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Color.fromRGBO(34, 45, 56, 0.0),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.more_vert,
                    ),
                    onPressed: () {})
              ],
            ),
            height: Utils.navigationBarHeight + Utils.topSafeHeight,
          ),
        ],
      ),
    );
  }
}
