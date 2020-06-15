import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';

import '../../page_index.dart';
import '../index.dart';

class SongListDetailsPage extends StatefulWidget {
  @override
  createState() => _SongListDetailsPageState();
}

class _SongListDetailsPageState extends State<SongListDetailsPage> {
  List<Song> list = [];

  double height = Utils.width * 0.6;

  LoaderState state = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getSongList();
  }

  @override
  Widget build(BuildContext context) {
    return LightTheme(
        child: Scaffold(
            body: Store.connect2<MusicModel, SongListModel>(
                builder: (_, MusicModel snapshot, SongListModel snapshot2,
                        __) =>
                    LoaderContainer(
                        contentView: Stack(
                          children: <Widget>[
                            ImageLoadView(
                                'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3877537738,1446238429&fm=26&gp=0.jpg',
                                fit: BoxFit.cover,
                                filterColor: Colors.black,
                                opacity: 0.4),
                            CustomScrollView(
                              slivers: <Widget>[
                                SliverAppBar(
                                    title: Text('默认歌单'),
                                    expandedHeight: height,
                                    pinned: true,
                                    elevation: 0.0,
                                    flexibleSpace: FlexibleSpaceBar(
                                      background: AspectRatio(
                                        aspectRatio: 0.6,
                                        child: ImageLoadView(
                                          backgroundImage,
                                          fit: BoxFit.cover,
                                          padding: EdgeInsets.only(
                                              top: Utils.navigationBarHeight),
                                          alignment: Alignment.center,
                                          child: CircleButton(
                                            onPressedAction: () {
                                              snapshot.playSongs(list);
                                            },
                                            fillColor: Colors.black26,
                                            elevation: 20.0,
                                            highlightElevation: 5,
                                            icon: Icons.play_arrow,
                                            iconSize: 55,
                                            size: 70,
                                          ),
                                        ),
                                      ),
                                    )),
                                buildSliverPersistentHeader(
                                    snapshot, snapshot2),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (_, index) =>
                                        ItemSongListSong(item: list[index]),
                                    childCount: list.length,
                                  ),
                                ),
                                SliverPadding(
                                  padding: EdgeInsets.only(
                                      bottom: 60.0 + Utils.bottomSafeHeight),
                                ),
                              ],
                            ),
                            Positioned(child: SongPlayerBar(), bottom: 0),
                            Positioned(
                              child: Material(
                                color: Colors.white,
                                child: Container(
                                  width: Utils.width,
                                  height: 60.0 + Utils.bottomSafeHeight,
                                  child: Row(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.playlist_play),
                                        onPressed: () {
                                          if (snapshot2.songNumber > 0) {
                                            snapshot.playSongs(snapshot2.songs);

                                            snapshot2.togglePlayerBarBottom();
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.playlist_add),
                                        onPressed: () {
                                          if (snapshot2.songNumber > 0) {
                                            snapshot.addSongs(snapshot2.songs);

                                            snapshot2.togglePlayerBarBottom();
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.save_alt),
                                        onPressed: () {
                                          /// TODO 下载选中的歌曲
                                          snapshot2.togglePlayerBarBottom();
                                        },
                                      ),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                  ),
                                ),
                              ),
                              bottom: snapshot2.choiceBottom,
                            ),
                          ],
                        ),
                        loaderState: state))));
  }

  Widget buildSliverPersistentHeader(
      MusicModel snapshot, SongListModel snapshot2) {
    return SliverPersistentHeader(
        delegate: CustomSliverAppBarDelegate(
            minHeight: 48,
            child: Material(
              color: Colors.white,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          Visibility(
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.play_circle_outline),
                                  onPressed: () {
                                    snapshot.playSongs(list);
                                  },
                                ),
                                Gaps.hGap10,
                                RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: '播放全部',
                                          style: TextStyles.textDark16),
                                      TextSpan(
                                          text: '（共${list?.length}首）',
                                          style: TextStyles.textDark14),
                                    ],
                                  ),
                                )
                              ],
                              mainAxisSize: MainAxisSize.min,
                            ),
                            visible: !snapshot2.showChoice,
                          ),
                          Visibility(
                            visible: snapshot2.showChoice,
                            child: Row(
                              children: <Widget>[
                                GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 30,
                                        width: 30,
                                        alignment: Alignment.center,
                                        child: Icon(
                                          snapshot2.songNumber == list.length
                                              ? Icons.check_box
                                              : snapshot2.songNumber == 0
                                                  ? Icons
                                                      .check_box_outline_blank
                                                  : Icons
                                                      .indeterminate_check_box,
                                          size: 20.0,
                                          color: snapshot2.songNumber > 0
                                              ? readerMainColor
                                              : Colors.black,
                                        ),
                                      ),
                                      Text('全选'),
                                    ],
                                    mainAxisSize: MainAxisSize.min,
                                  ),
                                  onTap: () {
                                    if (snapshot2.songNumber != list.length) {
                                      snapshot2.addAllSongs(list);
                                    } else {
                                      snapshot2.cancel();
                                    }
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    '已选${snapshot2.songNumber}首',
                                    style: TextStyles.textBlue14,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Text(snapshot2.showChoice ? "取消" : '全选',
                          style: TextStyles.textDark14),
                      onPressed: () {
                        snapshot2.togglePlayerBarBottom();
                      },
                    ),
                  ],
                ),
              ),
            ),
            maxHeight: 48),
        pinned: true);
  }

  void getSongList() async {
    List<Song> _list = await ApiService.getMusics();

    list.addAll(_list);

    if (mounted)
      setState(() {
        state = LoaderState.Succeed;
      });
  }
}
