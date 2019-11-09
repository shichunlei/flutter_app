import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

List data = [
  {
    'name': 'Antelope Canyon',
    'image':
        'https://images.unsplash.com/photo-1527498913931-c302284a62af?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80',
    'description':
        'Over the years, Lover Antelope Canyon has become a favorite gathering pace for photographers tourists, and visitors from the world.',
    'date': 'Mar 20, 2019',
    'rating': '4.7',
    'cost': '\$40.00'
  },
  {
    'name': 'Genteng Lembang',
    'image':
        'https://images.unsplash.com/photo-1548560781-a7a07d9d33db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=581&q=80',
    'description':
        'Over the years, Lover Antelope Canyon has become a favorite gathering pace for photographers tourists, and visitors from the world.',
    'date': 'Mar 24, 2019',
    'rating': '4.83',
    'cost': '\$50.00'
  },
  {
    'name': 'Kamchatka Peninsula',
    'image':
        'https://images.unsplash.com/photo-1542869781-a272dedbc93e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=983&q=80',
    'description':
        'Over the years, Lover Antelope Canyon has become a favorite gathering pace for photographers tourists, and visitors from the world.',
    'date': 'Apr 18, 2019',
    'rating': '4.75',
    'cost': '\$30.00'
  },
];

var profileImage =
    'https://www.imgmodels.com/sites/default/files/283adc16-7317-4189-bf7f-816367d68adf.jpg';

class TravelScreen extends StatelessWidget {
  TravelScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10),
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Search for place',
                      style: TextStyle(
                          color: Colors.black54,
                          decoration: TextDecoration.none),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Destination',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                                decoration: TextDecoration.none)),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black54,
                        )
                      ],
                    )
                  ],
                ),
                actions: <Widget>[
                  Center(
                    child: ImageLoadView(profileImage,
                        height: 45,
                        width: 45,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.all(Radius.circular(22.5))),
                  )
                ],
              ),
              height: Utils.navigationBarHeight,
            ),
            Gaps.vGap16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                height: 200.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: data.map((x) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => pushNewPage(context,
                            SecondScreen(x, tag: "${x['image']}-list")),
                        child: Hero(
                          tag: "${x['image']}-list",
                          child: Container(
                            height: 200.0,
                            width: 140.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black26, BlendMode.darken),
                                    image: NetworkImage(x['image']),
                                    fit: BoxFit.cover)),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(),
                                      Text(
                                        x['rating'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            decoration: TextDecoration.none),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    x['name'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        decoration: TextDecoration.none),
                                  ),
                                  Text(
                                    x['date'],
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12.0,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Gaps.vGap8
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Gaps.vGap8,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'VIEW ALL -',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Gaps.vGap(32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Container(
                height: 256.0,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        ItemCardView(data: data[0], height: 120.0),
                        SizedBox(height: 16.0),
                        ItemCardView(data: data[1], height: 120.0),
                      ],
                    ),
                    ItemCardView(data: data[2], height: 256.0),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemCardView extends StatelessWidget {
  final data, height;

  ItemCardView({Key key, this.data, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pushNewPage(
          context, SecondScreen(data, tag: "${data['image']}-item")),
      child: Hero(
        tag: "${data['image']}-item",
        child: Container(
          height: height,
          width: MediaQuery.of(context).size.width / 2 - 42,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                  image: NetworkImage(data['image']),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black26, BlendMode.darken))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(),
                Text(
                  data['name'],
                  style: TextStyle(
                      color: Colors.white, decoration: TextDecoration.none),
                ),
                Gaps.vGap4,
                Text(
                  data['date'],
                  style: TextStyle(
                      color: Colors.white54, decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final data;
  final String tag;

  SecondScreen(this.data, {@required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: tag,
            child: Image.network(
              data['image'],
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.darken,
              color: Colors.black54,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Spacer(),
                  Container(
                    width: 240.0,
                    child: Text(
                      data['name'],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                          fontSize: 42.0),
                    ),
                  ),
                  Gaps.vGap16,
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 14.0,
                      ),
                      Gaps.hGap4,
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 14.0,
                      ),
                      Gaps.hGap4,
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 14.0,
                      ),
                      Gaps.hGap4,
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 14.0,
                      ),
                      Gaps.hGap4,
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 14.0,
                      ),
                      Gaps.hGap8,
                      Text(
                        '${data['rating']}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Gaps.hGap4,
                      Text(
                        '(1072)',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                  Gaps.vGap16,
                  Container(
                    child: Text(
                      data['description'],
                      style: TextStyle(color: Colors.white54, height: 1.4),
                    ),
                  ),
                  Gaps.vGap16,
                  Text(
                    'READ MORE',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  Gaps.vGap16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 4.0,
                              height: 4.0,
                              decoration: BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.circular(50.0)),
                            ),
                            Gaps.hGap4,
                            Container(
                              width: 18.0,
                              height: 2.0,
                              color: Colors.white,
                            ),
                            Gaps.hGap4,
                            Container(
                              width: 4.0,
                              height: 4.0,
                              decoration: BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.circular(50.0)),
                            ),
                            Gaps.hGap4,
                            Container(
                              width: 4.0,
                              height: 4.0,
                              decoration: BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.circular(50.0)),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '${data['cost']}',
                            style:
                                TextStyle(color: Colors.white, fontSize: 28.0),
                          ),
                          Text(
                            '${data['date']}',
                            style: TextStyle(
                                color: Colors.white54, fontSize: 14.0),
                          ),
                        ],
                      )
                    ],
                  ),
                  Gaps.vGap20
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            color: Colors.transparent,
            height: Utils.navigationBarHeight,
            child: AppBar(
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                Center(
                  child: Text(
                    '02/10',
                    style: TextStyle(color: Colors.white, fontSize: 24.0),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
