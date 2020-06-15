import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../page_index.dart';
import '../index.dart';

class TopSongsPage extends StatefulWidget {
  final SubCategoryBean info;

  TopSongsPage({Key key, @required this.info}) : super(key: key);

  @override
  createState() => _TopSongsPageState();
}

class _TopSongsPageState extends State<TopSongsPage> {
  ScrollController _controller = ScrollController();

  int page = 1;

  SubCategoryBean get bean => widget.info;

  List<Song> list = [];

  /// 透明度 取值范围[0,1]
  double navAlpha = 0;
  double height = Utils.width * 0.6;

  double top = 0;

  LoaderState state = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      var offset = _controller.offset;

      if (offset <= 0) {
        if (navAlpha != 0) {
          setState(() {
            top = 0;
            navAlpha = 0;
          });
        }
      } else if (offset < height) {
        setState(() {
          navAlpha = 1 - (height - offset) / height;
          top = 0;
        });
      } else {
        if (offset < height + Utils.topSafeHeight) {
          setState(() {
            top = Utils.topSafeHeight - (height + Utils.topSafeHeight - offset);
          });
        } else {
          setState(() {
            top = Utils.topSafeHeight;
          });
        }
        if (navAlpha != 1) {
          setState(() {
            navAlpha = 1;
          });
        }
      }
    });

    getTopMusic();
  }

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
        body: LoaderContainer(
            contentView: Stack(
              children: <Widget>[
                ImageLoadView(
                  'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3877537738,1446238429&fm=26&gp=0.jpg',
                  fit: BoxFit.cover,
                  filterColor: Colors.black,
                  opacity: 0.4,
                ),
                CustomScrollView(
                  controller: _controller,
                  slivers: <Widget>[
                    SliverAppBar(
                      elevation: 0.0,
                      expandedHeight: height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: AspectRatio(
                          aspectRatio: 0.6,
                          child: ImageLoadView(
                            '${bean?.coverUrl}',
                            fit: BoxFit.cover,
                            filterColor: Colors.white,
                            opacity: 0.4,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: '${bean?.update}更新',
                                            style: TextStyles.textDark16),
                                        TextSpan(
                                            text: '  |  ',
                                            style: TextStyles.textDark14),
                                        TextSpan(
                                          text: '详情',
                                          style: TextStyles.textBlue16,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap =
                                                () => showTopInfo(context),
                                        )
                                      ],
                                    ),
                                  ),
                                  bottom: 10.0,
                                  left: 10.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        '${bean?.label}',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, navAlpha),
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                        delegate: CustomSliverAppBarDelegate(
                            minHeight: 48 + top,
                            child: Material(
                              color: Colors.white,
                              child: Container(
                                padding: EdgeInsets.only(top: top, left: 10),
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.play_arrow),
                                      onPressed: () {
                                        var snapshot =
                                            Store.value<MusicModel>(context);
                                        snapshot.playSongs(list);
                                      },
                                    ),
                                    Gaps.hGap10,
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: '播放全部',
                                              style: TextStyles.textDark16),
                                          TextSpan(
                                              text: '（共${list.length}首）',
                                              style: TextStyles.textDark14),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            maxHeight: 48 + top),
                        pinned: true),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, index) => ItemTopSongView(
                          item: list[index],
                          rank: index + 1,
                        ),
                        childCount: list.length,
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(
                          bottom: 60.0 + Utils.bottomSafeHeight),
                    ),
                  ],
                ),
              ],
            ),
            loaderState: state),
        bottomNavigationBar: SongPlayerBar(),
      ),
    );
  }

  void showTopInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) => Container(
        height: Utils.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.6,
                child: ImageLoadView('${bean?.coverUrl}'),
              ),
              Html(
                data: '${bean?.desc}',
                defaultTextStyle: TextStyle(fontSize: 20),
                padding: EdgeInsets.all(8.0),
                blockSpacing: 2.0,
                useRichText: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getTopMusic() async {
    List<Song> _list = await ApiService.getMusics();

    list.addAll(_list);

    if (mounted)
      setState(() {
        state = LoaderState.Succeed;
      });
  }
}
