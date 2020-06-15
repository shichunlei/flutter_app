import 'package:flutter/material.dart';
import 'package:flutter_app/bean/tubitv.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'details_header.dart';
import 'details_info.dart';
import 'item_season.dart';
import 'related_view.dart';

class DetailsPage extends StatefulWidget {
  final String id;

  DetailsPage({Key key, @required this.id}) : super(key: key);

  @override
  createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TuBiTV data;

  TuBiTV _data;

  List<TuBiTV> likes = [];
  List<TuBiTV> seasons = [];

  LoaderState state = LoaderState.Loading;

  int checkSeason = -1;
  int checkEpisode = -1;

  double expandedHeight;

  @override
  void initState() {
    super.initState();

    expandedHeight=Utils.width*0.7;

    getDetails(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DarkTheme(
      child: Scaffold(
        body: LoaderContainer(
          contentView: EasyRefresh.custom(
            slivers: [
              DetailsHeaderView(data: data,expandedHeight:expandedHeight),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    DetailsInfoView(data: data),
                    Visibility(
                      child: ItemSeasonView(
                        seasons: seasons,
                        callBack: (int season, int episode) {
                          setState(() {
                            state = LoaderState.Loading;
                          });

                          Future.delayed(Duration(milliseconds: 500), () {
                            setState(() {
                              checkSeason = season;
                              checkEpisode = episode;

                              data = _data
                                  .children[checkSeason].children[checkEpisode];
                              data.posterarts = _data.posterarts;
                              data.actors = _data.actors;
                              data.directors = _data.directors;
                              state = LoaderState.Succeed;
                            });
                          });
                        },
                        checkEpisode: checkEpisode,
                        checkSeason: checkSeason,
                      ),
                      visible: seasons.length > 0,
                    ),
                    RelatedView(likes: likes),
                  ],
                ),
              ),
            ],
          ),
          loaderState: state,
        ),
      ),
    );
  }

  void getDetails(String id) async {
    data = await ApiService.getTubiTVDetails(
        id: id,
        platform: Utils.isAndroid ? "android" : "iphone",
        deviceId: "111111");

    _data = data;

    likes.addAll(_data.related);
    seasons.addAll(_data.children);

    setState(() {
      state = LoaderState.Succeed;
    });
  }
}
