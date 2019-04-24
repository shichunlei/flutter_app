import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/avatar_glow.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MovieCelebrityHeader extends StatelessWidget {
  final String name;
  final Color pageColor;
  final String avatarUrl;
  final String backgroundImageUrl;
  final int gender;

  MovieCelebrityHeader(
    this.name, {
    Key key,
    this.pageColor = const Color(0xff35374c),
    this.avatarUrl = '',
    this.backgroundImageUrl = '',
    this.gender = -1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      pinned: true,
      expandedHeight: 200,
      backgroundColor: pageColor,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.favorite), onPressed: () {})
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(name),
        background: Stack(
          children: <Widget>[
            ImageLoadView(backgroundImageUrl,
                fit: BoxFit.fitWidth, width: double.infinity),

            /// 加上一层毛玻璃效果
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 6.0,
              ),
              child: Opacity(
                opacity: 0.4,
                child: Container(
                  decoration: BoxDecoration(
                    color: pageColor,
                  ),
                ),
              ),
            ),

            /// 头像
            Center(
              child: AvatarGlow(
                  startDelay: Duration(milliseconds: 1000),
                  glowColor: Colors.white,
                  endRadius: 90.0,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(avatarUrl),
                            radius: 40.0,
                          ),
                          Offstage(
                            offstage: gender == -1,
                            child: Icon(
                              gender == 1
                                  ? FontAwesomeIcons.mars
                                  : FontAwesomeIcons.venus,
                              size: 20,
                              color: gender == 0
                                  ? Colors.pinkAccent
                                  : Colors.blueAccent,
                            ),
                          ),
                        ],
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
