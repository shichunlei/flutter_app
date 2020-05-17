import 'package:flutter/material.dart';
import 'package:flutter_app/bean/doodle.dart';
import 'package:flutter_app/page_index.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class TimeLinePage extends StatefulWidget {
  @override
  createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage>
    with SingleTickerProviderStateMixin {
  final PageController pageController =
      PageController(initialPage: 1, keepPage: true);
  int pageIx = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      timelineModel(TimelinePosition.Left),
      timelineModel(TimelinePosition.Center),
      timelineModel(TimelinePosition.Right)
    ];

    return Scaffold(
        appBar: AppBar(title: Text('TimeLine')),
        body: PageView(
            onPageChanged: (i) => setState(() => pageIx = i),
            controller: pageController,
            children: pages),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: pageIx,
            onTap: (i) => pageController.animateToPage(i,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.format_align_left),
                title: Text("LEFT"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_align_center),
                title: Text("CENTER"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_align_right),
                title: Text("RIGHT"),
              ),
            ]));
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
      itemBuilder: centerTimelineBuilder,
      itemCount: doodles.length,
      position: position);

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final doodle = doodles[i];
    final textTheme = Theme.of(context).textTheme;
    return TimelineModel(
        Card(
          margin: EdgeInsets.symmetric(vertical: 16.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ImageLoadView(
                  doodle.doodle,
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
                Gaps.vGap8,
                Text(doodle.time, style: textTheme.caption),
                Gaps.vGap8,
                Text(doodle.name,
                    style: textTheme.subtitle1, textAlign: TextAlign.center),
                Gaps.vGap8,
              ],
            ),
          ),
        ),
        position:
            i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == doodles.length,
        iconBackground: doodle.iconBackground,
        icon: doodle.icon);
  }
}
