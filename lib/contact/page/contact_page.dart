import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/contact/ui/contact_category.dart';
import 'package:flutter_app/contact/ui/contact_image_text.dart';
import 'package:flutter_app/contact/ui/contact_item.dart';
import 'package:flutter_app/contact/ui/line_widget.dart';

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

  @override
  void initState() {
    super.initState();
    _appBarBehavior = AppBarBehavior.pinned;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        platform: Theme.of(context).platform,
      ),
      child: Scaffold(
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
                title: Text(widget.name),
                background: Stack(
                  /// 定义如何设置non-positioned节点尺寸，默认为loose
                  fit: StackFit.expand,// loose：子节点宽松的取值，可以从min到max的尺寸；expand：子节点尽可能的占用空间，取max尺寸；passthrough：不改变子节点的约束条件。
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                      placeholder: "images/flutter.png",
                      image: (widget.avatar == "" || widget.avatar == null)
                          ? _defaultImage
                          : widget.avatar,
                      fit: BoxFit.cover,
                      height: _appBarHeight,
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
                  _buildRowView(),
                  LineWidget(
                    height: 1.0,
                    color: Colors.black12,
                    lineType: LineType.horizontal,
                  ),
                  _buildPhoneView(),
                  _buildEmailView(),
                  _buildAddressView(),
                  _buildOtherView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isFavorite = false;
  IconData favoriteIcon = Icons.favorite_border;
  Color favoriteColor = Colors.grey;
  String favoriteText = "收藏";

  void _toggleFavorite() {
    setState(() {
      if (isFavorite) {
        isFavorite = false;
        favoriteIcon = Icons.favorite_border;
        favoriteColor = Colors.grey;
        favoriteText = "收藏";
      } else {
        isFavorite = true;
        favoriteIcon = Icons.favorite;
        favoriteColor = Colors.redAccent;
        favoriteText = "取消收藏";
      }
    });
  }

  Widget _buildRowView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ContactImageText(
          icon: Icon(
            Icons.share,
            color: Colors.grey,
          ),
          text: Text("分享"),
          onPressed: () {},
        ),
        LineWidget(
          height: 34.0,
          width: 1.0,
          lineType: LineType.vertical,
        ),
        ContactImageText(
          icon: Icon(
            Icons.history,
            color: Colors.grey,
          ),
          text: Text("通话记录"),
          onPressed: () {},
        ),
        LineWidget(
          height: 34.0,
          width: 1.0,
          lineType: LineType.vertical,
        ),
        ContactImageText(
          icon: Icon(
            favoriteIcon,
            color: favoriteColor,
          ),
          text: Text(favoriteText),
          onPressed: () => _toggleFavorite(),
        ),
      ],
    );
  }

  Widget _buildPhoneView() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: ContactCategory(
        icon: Icons.call,
        children: <Widget>[
          ContactItem(
            icon: Icons.message,
            tooltip: "send message",
            onPressed: () {},
            lines: const <String>[
              '18601952581',
              'Mobile',
            ],
          ),
          ContactItem(
            icon: Icons.message,
            tooltip: "send message",
            onPressed: () {},
            lines: const <String>[
              '13522038091',
              'Work',
            ],
          ),
          ContactItem(
            icon: Icons.message,
            tooltip: "send message",
            onPressed: () {},
            lines: const <String>[
              '18510634252',
              'Home',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmailView() {
    return ContactCategory(
      icon: Icons.contact_mail,
      children: <Widget>[
        ContactItem(
          icon: Icons.email,
          tooltip: "Send personal e-mail",
          onPressed: () {},
          lines: const <String>[
            '1558053958@qq.com',
            'Personal',
          ],
        ),
        ContactItem(
          icon: Icons.email,
          tooltip: 'Send work e-mail',
          onPressed: () {},
          lines: const <String>[
            'scl@chingsoft.com',
            'Work',
          ],
        ),
      ],
    );
  }

  Widget _buildAddressView() {
    return ContactCategory(
      icon: Icons.location_on,
      children: <Widget>[
        ContactItem(
          icon: Icons.map,
          tooltip: 'Open map',
          onPressed: () {},
          lines: const <String>[
            '中国北京市海淀区',
            '四季青镇龚村173号',
            'Home',
          ],
        ),
        ContactItem(
          icon: Icons.map,
          tooltip: 'Open map',
          onPressed: () {},
          lines: const <String>[
            '中国北京市海淀区',
            '中关村梦想实验室8层806室',
            'Work',
          ],
        ),
        ContactItem(
          icon: Icons.map,
          tooltip: 'Open map',
          onPressed: () {},
          lines: const <String>[
            '中国河北省衡水市',
            '阜城县漫河乡前宣屯村',
            'Jet Travel',
          ],
        ),
      ],
    );
  }

  Widget _buildOtherView() {
    return ContactCategory(
      icon: Icons.today,
      children: <Widget>[
        ContactItem(
          lines: const <String>[
            'Birthday',
            'January 9th, 1989',
          ],
        ),
        ContactItem(
          lines: const <String>[
            'Wedding anniversary',
            'June 21st, 2014',
          ],
        ),
        ContactItem(
          lines: const <String>[
            'First day in office',
            'January 20th, 2015',
          ],
        ),
        ContactItem(
          lines: const <String>[
            'Last day in office',
            'August 9th, 2018',
          ],
        ),
      ],
    );
  }
}
