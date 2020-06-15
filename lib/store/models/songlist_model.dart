import 'package:flutter/material.dart';
import 'package:flutter_app/bean/music.dart';

import '../../page_index.dart';

class SongListModel extends ChangeNotifier {
  List<Song> _songs = [];

  List<Song> get songs => _songs;

  int get songNumber => _songs.length;

  double _choiceBottom = -60 - Utils.bottomSafeHeight;

  double get choiceBottom => _choiceBottom;

  bool _showChoice = false;

  bool get showChoice => _showChoice;

  /// 设置播放条隐藏显示
  ///
  void togglePlayerBarBottom() {
    if (_showChoice) {
      cancel();
      _showChoice = false;
      _choiceBottom = -60 - Utils.bottomSafeHeight;
    } else {
      _showChoice = true;
      _choiceBottom = 0.0;
    }
    notifyListeners();
  }

  void addAllSongs(List<Song> songs) {
    this._songs.clear();
    this._songs.addAll(songs);
    notifyListeners();
  }

  void toggleSong(Song song) {
    if (this._songs.contains(song)) {
      this._songs.remove(song);
    } else {
      this._songs.add(song);
    }
    notifyListeners();
  }

  void cancel() {
    this._songs.clear();
  }
}
