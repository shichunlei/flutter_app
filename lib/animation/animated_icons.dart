import 'package:flutter/material.dart';

class AnimatedIconsDemo extends StatefulWidget {
  AnimatedIconsDemo({Key key}) : super(key: key);

  @override
  createState() => _AnimatedIconsDemoState();
}

class _AnimatedIconsDemoState extends State<AnimatedIconsDemo>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000), value: 1.0);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var icons = [
      AnimatedIcons.add_event,
      AnimatedIcons.arrow_menu,
      AnimatedIcons.close_menu,
      AnimatedIcons.ellipsis_search,
      AnimatedIcons.event_add,
      AnimatedIcons.home_menu,
      AnimatedIcons.list_view,
      AnimatedIcons.menu_arrow,
      AnimatedIcons.menu_close,
      AnimatedIcons.menu_home,
      AnimatedIcons.pause_play,
      AnimatedIcons.play_pause,
      AnimatedIcons.search_ellipsis,
      AnimatedIcons.view_list
    ];

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('AnimatedIcons')),
        body: GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: icons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0),
            itemBuilder: (context, i) => Center(
                child: IconButton(
                    icon: AnimatedIcon(
                        size: 30.0,
                        icon: icons[i],
                        progress: animationController.view,
                        semanticLabel: 'Show menu'),
                    onPressed: () => animationController.fling(
                        velocity: _status ? -2.0 : 2.0)))));
  }

  bool get _status {
    final AnimationStatus status = animationController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }
}
