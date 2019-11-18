import 'package:flutter/material.dart';
import 'package:flutter_app/bean/tubitv.dart';

import '../page_index.dart';
import 'item_episode.dart';

class ItemSeasonView extends StatefulWidget {
  const ItemSeasonView(
      {Key key,
      @required this.seasons,
      this.callBack,
      this.checkSeason: -1,
      this.checkEpisode: -1})
      : super(key: key);

  final List<TuBiTV> seasons;
  final Function(int season, int episode) callBack;
  final int checkSeason;
  final int checkEpisode;

  @override
  createState() => _ItemSeasonViewState();
}

class _ItemSeasonViewState extends State<ItemSeasonView> {
  List<TuBiTV> episodes = [];

  int curSeason;

  TuBiTV _season;

  @override
  void initState() {
    super.initState();

    curSeason = widget.checkSeason >= 0 ? widget.checkSeason : 0;

    if (widget.seasons.length > 0) {
      _season = widget.seasons[curSeason];
      episodes.addAll(_season.children);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (_, StateSetter setState) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: widget.seasons.length > 0
                  ? DropdownButton<TuBiTV>(
                      isExpanded: true,
                      value: _season,
                      onChanged: (value) {
                        setState(() {
                          _season = value;
                          curSeason = widget.seasons.indexOf(_season);
                          episodes.clear();
                          episodes.addAll(_season.children);
                        });
                      },
                      items: widget.seasons
                          .map((value) => DropdownMenuItem<TuBiTV>(
                                value: value,
                                child: Text(
                                  '${value?.title}',
                                  style: TextStyles.textGreyC16,
                                ),
                              ))
                          .toList(),
//                      selectedItemBuilder: (_) {
//                        return widget.seasons
//                            .map((value) => DropdownMenuItem<TuBiTV>(
//                                  value: value,
//                                  child: Text(
//                                    '${value?.title}',
//                                    style: TextStyles.textGreyC16,
//                                  ),
//                                ))
//                            .toList();
//                      },
                    )
                  : SizedBox(),
            ),
            SizedBox(
              height: 242,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => ItemEpisodeView(
                        item: episodes[index],
                        isCheck: index == widget.checkEpisode &&
                            curSeason == widget.checkSeason,
                        onTap: () {
                          setState(() {
                            widget.callBack(curSeason, index);
                          });
                        },
                      ),
                  itemCount: episodes?.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Gaps.hGap8,
                  physics: BouncingScrollPhysics()),
            )
          ],
        ),
      );
    });
  }
}
