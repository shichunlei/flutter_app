import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/movie/bean/celebrity.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/page/movie_photo.dart';
import 'package:flutter_app/movie/page/movie_photos.dart';
import 'package:flutter_app/movie/page/movie_with_celebrity.dart';
import 'package:flutter_app/movie/service/api_service.dart';
import 'package:flutter_app/movie/ui/cover_section_view.dart';
import 'package:flutter_app/movie/ui/expandable_text.dart';
import 'package:flutter_app/movie/ui/home_section_view.dart';
import 'package:flutter_app/movie/ui/movie_celebrity_header.dart';
import 'package:flutter_app/movie/ui/movie_grid_view.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:transparent_image/transparent_image.dart';

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

  PaletteGenerator paletteGenerator;

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
          '\n\n星座：${celebrity.constellation.length == 0 ? '未知' : celebrity.constellation}';
      desc += '\n${celebrity.birthday}生于${celebrity.born_place}';

      celebrity.aka_en.map((aka) {
        desc += '\n$aka';
      }).toList();

      return Scaffold(
        backgroundColor: pageColor,
        body: CustomScrollView(
          slivers: <Widget>[
            MovieCelebrityHeader(
              widget.name,
              backgroundImageUrl: celebrity.photos.length == 0
                  ? defaultBgImageUrl
                  : celebrity.photos[0].cover,
              pageColor: pageColor,
              avatarUrl: celebrity.avatars.medium.toString(),
              gender: celebrity.gender == '男'
                  ? 1
                  : celebrity.gender == '女' ? 0 : -1,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  HomeSectionView("简介",
                      hiddenMore: true,
                      backgroundColor: pageColor,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
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
                    onPressed: () => pushNewPage(
                        context,
                        MoviePhotosPage(
                            celebrity.name, 'celebrity', widget.id)),
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
                          child: GestureDetector(
                              child: ClipRRect(
                                /// 圆角
                                borderRadius: BorderRadius.circular(6.0),
                                child: Hero(
                                    tag: celebrity.photos[index].id,
                                    child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: celebrity.photos[index].cover,
                                      fit: BoxFit.cover,
                                      height: height,
                                      width: height,
                                    )),
                              ),
                              onTap: () => pushNewPage(
                                  context,
                                  MoviePhotoPage(widget.name,
                                      photos: celebrity.photos, index: index))),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  void getPersonDetail(id) async {
    celebrity = await ApiService.getActorDetail(id);

    if (celebrity.photos.length > 0) {
      paletteGenerator = await PaletteGenerator.fromImageProvider(
          NetworkImage(celebrity.photos[0].cover));
    } else {
      paletteGenerator = await PaletteGenerator.fromImageProvider(
          NetworkImage(celebrity.avatars.small));
    }

    setState(() {
      if (paletteGenerator.darkVibrantColor != null) {
        pageColor = paletteGenerator.darkVibrantColor.color;
      }
    });
  }

  /// 展开 or 收起
  changeSummaryMaxLines() {
    setState(() {
      isSummaryUnfold = !isSummaryUnfold;
    });
  }
}
