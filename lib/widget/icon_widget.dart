import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/global/custom_icon.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class IconWidget extends StatefulWidget {
  @override
  _IconWidgetState createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
      value: 1.0,
    );
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
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
      AnimatedIcons.view_list,
      Icons.adb,
      FontAwesome.firefox,
      Feather.activity,
      CustomIcon.man,
      CustomIcon.back,
      CupertinoIcons.home
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('IconWidget'),
        elevation: 0.0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: icons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
        ),
        itemBuilder: (context, i) => Center(
          child: IconButton(
            icon: i > 13
                ? Icon(icons[i])
                : AnimatedIcon(
                    size: 30.0,
                    icon: icons[i],
                    progress: animationController.view,
                    semanticLabel: 'Show menu'),
            onPressed: () =>
                animationController.fling(velocity: _status ? -2.0 : 2.0),
          ),
        ),
      ),
    );
  }

  bool get _status {
    final AnimationStatus status = animationController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }
}
