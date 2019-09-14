import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDemo extends StatelessWidget {
  ShimmerDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('骨架屏示例')),
      body: Column(
        children: [
          ListTile(
            title: Text('Loading List'),
            onTap: () => pushNewPage(context, LoadingListPage()),
          ),
          ListTile(
            title: Text('Slide To Unlock'),
            onTap: () => pushNewPage(context, SlideToUnlockPage()),
          ),
        ],
      ),
    );
  }
}

class LoadingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading List'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        children: [0, 1, 2, 3, 4, 5, 6, 7]
            .map(
              (_) => Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 58.0,
                        height: 58.0,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: 40.0,
                              height: 8.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class SlideToUnlockPage extends StatelessWidget {
  final days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    final time = DateTime.now();
    final hour = time.hour;
    final minute = time.minute;
    final day = time.weekday;
    final month = time.month;
    final dayInMonth = time.day;
    return Scaffold(
      appBar: AppBar(
        title: Text('Slide To Unlock'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          ImageLoadView(
            'https://github.com/hnvn/flutter_shimmer/blob/master/example/assets/images/background.jpg?raw=true',
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 48.0,
            right: 0.0,
            left: 0.0,
            child: Center(
              child: Column(
                children: [
                  Text(
                    '${hour < 10 ? '0$hour' : '$hour'}:${minute < 10 ? '0$minute' : '$minute'}',
                    style: TextStyle(
                      fontSize: 60.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                  ),
                  Text(
                    '${days[day - 1]}, ${months[month - 1]} $dayInMonth',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 24.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Opacity(
                opacity: 0.8,
                child: Shimmer.fromColors(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageLoadView(
                        'https://github.com/hnvn/flutter_shimmer/blob/master/example/assets/images/chevron_right.png?raw=true',
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      ),
                      Text(
                        'Slide to unlock',
                        style: TextStyle(
                          fontSize: 28.0,
                        ),
                      ),
                    ],
                  ),
                  baseColor: Colors.black12,
                  highlightColor: Colors.white,
                  loop: 3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
