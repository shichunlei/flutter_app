import 'dart:ui';

import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class MovieCelebrityPage extends StatefulWidget {
  final String id;
  final String name;

  MovieCelebrityPage({
    Key key,
    @required this.id,
    this.name,
  }) : super(key: key);

  @override
  createState() => _MovieCelebrityPageState();
}

class _MovieCelebrityPageState extends State<MovieCelebrityPage> {
  Color pageColor = Color(0xff35374c);

  Celebrity celebrity;

  bool isSummaryUnfold = false;

  @override
  void initState() {
    super.initState();

    getPersonDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    if (null == celebrity) {
      return Scaffold(
        backgroundColor: pageColor,
        body: LoadingWidget(),
      );
    } else {
      List<Movie> movies = celebrity.subjects;

      double width = (Utils.width - 6 * 2 - 5 * 2) / 3;
      double height = width * 383 / 270 + 50;

      String desc = celebrity.summary;
      desc +=
          '\n\n星座：${celebrity.constellation.isEmpty ? '未知' : celebrity.constellation}';
      desc += '\n${celebrity.birthday}生于${celebrity.bornPlace}';

      celebrity.akaEn.map((aka) {
        desc += '\n$aka';
      }).toList();

      return Scaffold(
        backgroundColor: pageColor,
        body: CustomScrollView(slivers: <Widget>[
          MovieCelebrityHeader(
            widget.name,
            backgroundImageUrl: celebrity.photos.length > 0
                ? celebrity?.photos?.first?.cover
                : backgroundImage,
            pageColor: pageColor,
            avatarUrl: celebrity.avatars.medium.toString(),
            gender:
                celebrity.gender == '男' ? 1 : celebrity.gender == '女' ? 0 : -1,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                SectionView(
                  "简介",
                  hiddenMore: true,
                  textColor: Colors.white,
                  child: Padding(
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
                      List<String> images = [];
                      celebrity.photos.forEach((f) {
                        images.add(f.image);
                      });

                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0)),
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: GestureDetector(
                          onTap: () => pushNewPage(
                              context,
                              PhotoView(
                                title: widget.name,
                                photos: images,
                                index: index,
                                heroTag: celebrity.photos[index].id,
                              )),
                          child: Hero(
                              tag: celebrity.photos[index].id,
                              child: Image.network(
                                celebrity.photos[index].cover,
                                // borderRadius: BorderRadius.circular(6.0),
                                fit: BoxFit.cover,
                                height: height,
                                width: height,
                              )),
                        ),
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
      pageColor = await Utils.getImageDominantColor(
          celebrity?.avatars?.small ?? douBanDefaultImage);
    }

    if (mounted) setState(() {});
  }

  /// 展开 or 收起
  changeSummaryMaxLines() {
    setState(() {
      isSummaryUnfold = !isSummaryUnfold;
    });
  }
}
