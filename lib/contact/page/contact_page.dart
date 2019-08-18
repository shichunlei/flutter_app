import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/ui/image_load_view.dart';

import '../index.dart';

class ContactPage extends StatefulWidget {
  final String name;
  final String phone;
  final String avatar;

  ContactPage({Key key, this.name, this.phone, this.avatar}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class _ContactPageState extends State<ContactPage> {
  final String _defaultImage =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531798262708&di=53d278a8427f482c5b836fa0e057f4ea&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F342ac65c103853434cc02dda9f13b07eca80883a.jpg";
  final double _appBarHeight = 256.0;

  AppBarBehavior _appBarBehavior;

  Future<Null> _launched;

  @override
  void initState() {
    super.initState();
    _appBarBehavior = AppBarBehavior.pinned;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit),
        mini: true,
        elevation: 8.0,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: _appBarHeight,
            pinned: _appBarBehavior == AppBarBehavior.pinned,
            floating: _appBarBehavior == AppBarBehavior.floating ||
                _appBarBehavior == AppBarBehavior.snapping,
            snap: _appBarBehavior == AppBarBehavior.snapping,
            actions: <Widget>[
              PopupMenuButton<AppBarBehavior>(
                onSelected: (AppBarBehavior value) {
                  setState(() {
                    _appBarBehavior = value;
                  });
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuItem<AppBarBehavior>>[
                  const PopupMenuItem<AppBarBehavior>(
                      value: AppBarBehavior.normal,
                      child: Text('App bar scrolls away')),
                  const PopupMenuItem<AppBarBehavior>(
                      value: AppBarBehavior.pinned,
                      child: Text('App bar stays put')),
                  const PopupMenuItem<AppBarBehavior>(
                      value: AppBarBehavior.floating,
                      child: Text('App bar floats')),
                  const PopupMenuItem<AppBarBehavior>(
                      value: AppBarBehavior.snapping,
                      child: Text('App bar snaps')),
                ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(widget.name),
              background: Stack(
                /// 定义如何设置non-positioned节点尺寸，默认为loose
                fit: StackFit.expand,
                // loose：子节点宽松的取值，可以从min到max的尺寸；expand：子节点尽可能的占用空间，取max尺寸；passthrough：不改变子节点的约束条件。
                children: <Widget>[
                  Arc(
                    height: 50.0,
                    edge: Edge.BOTTOM,
                    arcType: ArcType.CONVEX,
                    child: ImageLoadView(
                        (widget.avatar == "" || widget.avatar == null)
                            ? _defaultImage
                            : widget.avatar,
                        height: _appBarHeight),
                  ),
                  // This gradient ensures that the toolbar icons are distinct
                  // against the background image.
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, -0.4),
                        colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                BuildRowView(),
                LineWidget(
                  height: 1.0,
                  color: Colors.black12,
                  lineType: LineType.horizontal,
                ),
                BuildPhoneView(phone: widget.phone, launched: _launched),
                BuildEmailView(),
                BuildAddressView(),
                BuildOtherView(),
                FutureBuilder<Null>(future: _launched, builder: _launchStatus),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<Null> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }
}
