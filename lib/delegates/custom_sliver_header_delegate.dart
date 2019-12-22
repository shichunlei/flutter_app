import 'package:flutter/material.dart';

import '../page_index.dart';

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double navigationBarHeight;
  final double expandedHeight;
  final String coverImgUrl;
  final String avatarImgUrl;
  final Widget child;
  final String title;

  SliverCustomHeaderDelegate(
      {this.navigationBarHeight,
      this.expandedHeight,
      this.coverImgUrl,
      this.child,
      this.avatarImgUrl,
      this.title});

  @override
  double get minExtent => this.navigationBarHeight;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
          .clamp(0, 255)
          .toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ImageLoadView(
            this.coverImgUrl,
          ),
          Center(
            child: Hero(
              tag: '${this.title}',
              child: avatarImgUrl == ""
                  ? CircleAvatar(
                      child: Text(title[0]),
                      radius: 60,
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(avatarImgUrl),
                      radius: 60,
                    ),
            ),
          ),
          Positioned(
            left: 0,
            top: this.maxExtent / 2,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00000000),
                    Color(0x90000000),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Material(
              color: this.makeStickyHeaderBgColor(shrinkOffset),
              child: Container(
                padding: EdgeInsets.only(top: Utils.topSafeHeight),
                height: navigationBarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color:
                            this.makeStickyHeaderTextColor(shrinkOffset, true),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      this.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:
                            this.makeStickyHeaderTextColor(shrinkOffset, false),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.share,
                        color:
                            this.makeStickyHeaderTextColor(shrinkOffset, true),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
