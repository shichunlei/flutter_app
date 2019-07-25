import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/celebrity.dart';
import 'package:flutter_app/bean/movie.dart';
import '../page/movie_photo.dart';
import '../page/movie_photos.dart';
import '../page/movie_with_celebrity.dart';
import 'package:flutter_app/service/api_service.dart';
import '../ui/cover_section_view.dart';
import '../ui/expandable_text.dart';
import '../ui/movie_celebrity_header.dart';
import '../ui/movie_grid_view.dart';

import '../../page_index.dart';

class MovieCelebrityPage extends StatefulWidget {
  final String id;
  final String name;

  MovieCelebrityPage({
    Key key,
    this.id,
    this.name,
  }) : super(key: key);

  @override
  createState() => _MovieCelebrityPageState();
}

class _MovieCelebrityPageState extends State<MovieCelebrityPage> {
  Color pageColor = Color(0xff35374c);

  Celebrity celebrity;

  bool isSummaryUnfold = false;

  String defaultBgImageUrl =
      'http://pic36.nipic.com/20131206/15190732_161014639124_2.png';

  @override
  void initState() {
    super.initState();

    getPersonDetail(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (null == celebrity) {
      return Scaffold(
        backgroundColor: pageColor,
        body: getLoadingWidget(),
      );
    } else {
      List<Movie> movies = [];

      celebrity.works.map((work) {
        movies.add(work.subject);
      }).toList();

      double width = (Utils.width - 6 * 2 - 5 * 2) / 3;
      double height = width * 383 / 270 + 50;

      String desc = celebrity.summary;
      desc +=
          '\n\n星座：${celebrity.constellation.isEmpty ? '未知' : celebrity.constellation}';
      desc += '\n${celebrity.birthday}生于${celebrity.born_place}';

      celebrity.aka_en.map((aka) {
        desc += '\n$aka';
      }).toList();

      return Scaffold(
        backgroundColor: pageColor,
        body: CustomScrollView(slivers: <Widget>[
          MovieCelebrityHeader(
            widget.name,
            backgroundImageUrl: celebrity.photos.isEmpty
                ? defaultBgImageUrl
                : celebrity.photos[0].cover,
            pageColor: pageColor,
            avatarUrl: celebrity.avatars.medium.toString(),
            gender:
                celebrity.gender == '男' ? 1 : celebrity.gender == '女' ? 0 : -1,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                SectionView("简介",
                    hiddenMore: true,
                    textColor: Colors.white),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: ExpandableText(
                    desc,
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    iconTextColor: Colors.white,
                    alignment: MainAxisAlignment.center,
                    fontSize: 15.0,
                    isShow: isSummaryUnfold,
                    onPressed: () => changeSummaryMaxLines(),
                  ),
                ),
                CoverSectionView(
                  '影视作品',
                  hiddenMore: movies.length < 5,
                  onPressed: () => pushNewPage(context,
                      MovieWithCelebrityPage(widget.id, celebrity.name)),
                  backgroundColor: pageColor,
                  height: height,
                  size: movies.length,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: MovieGridView(movies[index],
                              textColor: Colors.white),
                        );
                      },
                    ),
                  ),
                ),
                CoverSectionView(
                  '相册',
                  hiddenMore: celebrity.photos.length < 10,
                  onPressed: () => pushNewPage(context,
                      MoviePhotosPage(celebrity.name, 'celebrity', widget.id)),
                  backgroundColor: pageColor,
                  height: height,
                  size: celebrity.photos.length,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: celebrity.photos.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Hero(
                            tag: celebrity.photos[index].id,
                            child: ImageLoadView(celebrity.photos[index].cover,
                                borderRadius: BorderRadius.circular(6.0),
                                fit: BoxFit.cover,
                                height: height,
                                width: height,
                                onPressed: () => pushNewPage(
                                    context,
                                    MoviePhotoPage(widget.name,
                                        photos: celebrity.photos,
                                        index: index)))),
                      );
                    },
                  ),
                ),
                Gaps.vGap10
              ],
            ),
          ),
        ]),
      );
    }
  }

  void getPersonDetail(id) async {
    celebrity = await ApiService.getActorDetail(id);

    if (celebrity.photos.isNotEmpty) {
      pageColor = await Utils.getImageDominantColor(celebrity.photos[0].cover);
    } else {
      pageColor = await Utils.getImageDominantColor(celebrity.avatars.small);
    }

    setState(() {});
  }

  /// 展开 or 收起
  changeSummaryMaxLines() {
    setState(() {
      isSummaryUnfold = !isSummaryUnfold;
    });
  }
}
