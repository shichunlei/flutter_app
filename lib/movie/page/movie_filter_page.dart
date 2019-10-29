import 'package:flutter/material.dart';
import 'package:flutter_app/bean/condition.dart';

import 'package:flutter_app/movie/index.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../page_index.dart';

class MovieFilterPage extends StatefulWidget {
  @override
  createState() => _MovieFilterPageState();
}

class _MovieFilterPageState extends State<MovieFilterPage> {
  DropdownMenuController _dropdownMenuController = DropdownMenuController();

  var _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey _stackKey = GlobalKey();

  List<String> _dropDownHeaderItem = [
    '类型',
    '近期热门',
    '地区',
    '年代',
    '筛选',
  ];

  int page = 1;

  bool isLoadComplete = false;

  List<Movie> movies = [];

  var _scrollController = ScrollController();
  var _showBackTop = false;

  LoaderState state = LoaderState.Loading;

  bool isList = true;

  Condition scCountry;

  Condition scGenre;

  Condition scSort;

  Condition scYear;

  double min = 0.0;

  double max = 10.0;

  String range = "0.0,10.0";
  String feature = '';
  bool playable = false;
  bool unwatched = false;

  @override
  void initState() {
    super.initState();

    scCountry = countries.first;
    scSort = sorts.first;
    scGenre = genres.first;
    scYear = years.first;

    searchMovies(page, RefreshType.DEFAULT);

    // 对 scrollController 进行监听
    _scrollController.addListener(() {
      // _scrollController.position.pixels 获取当前滚动部件滚动的距离
      // 当滚动距离大于 800 之后，显示回到顶部按钮
      setState(() => _showBackTop = _scrollController.position.pixels >= 800);
    });
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    _dropdownMenuController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('选电影'),
          actions: <Widget>[
            IconButton(
                icon: Icon(isList ? Icons.apps : Icons.menu),
                onPressed: () {
                  setState(() {
                    isList = !isList;
                  });
                })
          ],
        ),
        body: Stack(
          key: _stackKey,
          children: <Widget>[
            Column(
              children: <Widget>[
                DropDownHeader(
                  stackKey: _stackKey,
                  controller: _dropdownMenuController,
                  items: [
                    DropDownHeaderItem(_dropDownHeaderItem[0]),
                    DropDownHeaderItem(_dropDownHeaderItem[1]),
                    DropDownHeaderItem(_dropDownHeaderItem[2]),
                    DropDownHeaderItem(_dropDownHeaderItem[3]),
                    DropDownHeaderItem(_dropDownHeaderItem[4]),
                  ],
                ),
                Expanded(
                  child: LoaderContainer(
                    contentView: buildBodyView(),
                    loaderState: state,
                  ),
                ),
              ],
            ),
            DropDownMenu(
              controller: _dropdownMenuController,
              menus: [
                DropdownMenuBuilder(
                    dropDownHeight: 60.0 * 8,
                    dropDownWidget: FilterListView(
                        items: genres,
                        itemOnTap: (value) {
                          scGenre = value;
                          _dropDownHeaderItem.first = scGenre.title;

                          _dropdownMenuController.hide();
                          setState(() {
                            page = 1;
                            state = LoaderState.Loading;
                            searchMovies(page, RefreshType.REFRESH);
                          });
                        })),
                DropdownMenuBuilder(
                    dropDownHeight: 60.0 * 4,
                    dropDownWidget: FilterListView(
                        items: sorts,
                        itemOnTap: (value) {
                          scSort = value;
                          _dropDownHeaderItem[1] = scSort.title;

                          _dropdownMenuController.hide();
                          setState(() {
                            page = 1;
                            state = LoaderState.Loading;
                            searchMovies(page, RefreshType.REFRESH);
                          });
                        })),
                DropdownMenuBuilder(
                    dropDownHeight: 60.0 * 8,
                    dropDownWidget: FilterListView(
                        items: countries,
                        itemOnTap: (value) {
                          scCountry = value;
                          _dropDownHeaderItem[2] = scCountry.title;

                          _dropdownMenuController.hide();
                          setState(() {
                            page = 1;
                            state = LoaderState.Loading;
                            searchMovies(page, RefreshType.REFRESH);
                          });
                        })),
                DropdownMenuBuilder(
                    dropDownHeight: 60.0 * 8,
                    dropDownWidget: FilterListView(
                        items: years,
                        itemOnTap: (value) {
                          scYear = value;
                          _dropDownHeaderItem[3] = scYear.title;

                          _dropdownMenuController.hide();
                          setState(() {
                            page = 1;
                            state = LoaderState.Loading;
                            searchMovies(page, RefreshType.REFRESH);
                          });
                        })),
                DropdownMenuBuilder(
                  dropDownHeight: 430,
                  dropDownWidget: FilterView(
                    rangeValues: RangeValues(min, max),
                    feature: feature,
                    unwatched: unwatched,
                    playable: playable,
                    onPressed: (min, max, feature, playable, unwatched) {
                      _dropdownMenuController.hide();
                      setState(() {
                        this.range = "$min,$max";

                        this.max = max;
                        this.min = min;
                        this.feature = feature;
                        this.playable = playable;
                        this.unwatched = unwatched;

                        page = 1;
                        state = LoaderState.Loading;
                        searchMovies(page, RefreshType.REFRESH);
                      });
                      print("$max==============$min");
                    },
                  ),
                ),
              ],
            )
          ],
        ),
        floatingActionButton: _showBackTop // 当需要显示的时候展示按钮，不需要的时候隐藏，设置 null
            ? FloatingActionButton(
                onPressed: () {
                  // scrollController 通过 animateTo 方法滚动到某个具体高度
                  // duration 表示动画的时长，curve 表示动画的运行方式，flutter 在 Curves 提供了许多方式
                  _scrollController.animateTo(0.0,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.decelerate);
                },
                child: Icon(Icons.vertical_align_top))
            : null);
  }

  Widget buildBodyView() {
    return EasyRefresh(
      footer: BallPulseFooter(),
      header: BallPulseHeader(),
      onLoad: isLoadComplete
          ? null
          : () async {
              page++;
              searchMovies(page, RefreshType.LOAD_MORE);
            },
      onRefresh: () async {
        page = 1;
        setState(() {
          state = LoaderState.Loading;
        });
        searchMovies(page, RefreshType.REFRESH);
      },
      child: isList
          ? ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) => ItemList(
                movie: movies[index],
                onTap: () =>
                    pushNewPage(context, MovieDetail(movies[index].id)),
              ),
              itemCount: movies.length,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(5.0),
            )
          : SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.all(6.0),
              physics: const BouncingScrollPhysics(),
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: movies.map((movie) => MovieGridView(movie)).toList(),
              ),
            ),
    );
  }

  void searchMovies(page, type) async {
    List<Movie> list = await ApiService.getFilterList(
        page: page,
        yearRange: scYear.value,
        countries: scCountry.value,
        sort: scSort.value,
        type: "电影",
        genres: scGenre.value,
        range: range,
        feature: feature,
        playable: playable,
        unwatched: unwatched);

    if (type == RefreshType.DEFAULT || RefreshType.REFRESH == type) {
      if (list.length == 0) {
        state = LoaderState.NoData;
      } else {
        state = LoaderState.Succeed;
        if (list.length > 0) {
          movies.clear();
        }

        if (list.length < 20) {
          isLoadComplete = true;
        }
      }
    }
    movies.addAll(list);

    setState(() {});
  }
}
