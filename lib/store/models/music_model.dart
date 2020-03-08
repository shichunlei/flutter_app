import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/music.dart';

import '../../page_index.dart';

class MusicModel extends ChangeNotifier {
  AudioPlayer _audioPlayer;

  AudioPlayerState _curState;

  List<Song> _songs = [];

  /// 播放列表所有歌曲
  List<Song> get allSongs => _songs;

  /// 当前播放歌曲下标
  int curIndex = 0;

  /// 总时长
  Duration _duration;

  Duration get duration => _duration;

  Duration _position;

  /// 歌曲时长
  String get durationText => Utils.duration2String(_duration);

  /// 歌曲当前播放时长
  String get positionText => Utils.duration2String(_position);

  int _mode;
  IconData _modeIcon;

  /// 播放模式
  int get mode => _mode;

  IconData get modeIcon => _modeIcon;

  double _progress = 0.0;

  /// 播放进度
  double get progress => _progress;

  /// 正在播放状态
  bool get isPlaying => _curState == AudioPlayerState.PLAYING;

  /// 当前音乐
  Song get curSong => _songs.length == 0 ? null : _songs[curIndex];

  void init() async {
    int mode = SpUtil.getInt("song_mode", defValue: 0);
    toggleMode(mode);

    getMusics();

    _audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER)
      ..setReleaseMode(ReleaseMode.RELEASE)
      ..onDurationChanged.listen(
        (Duration duration) => _duration = duration,
      )

      /// 当前播放进度监听
      ..onAudioPositionChanged.listen(
        (Duration position) {
          _position = position;

          if (_duration != null &&
              _position != null &&
              _duration.inMilliseconds > 0) {
            _progress = _position.inMilliseconds / _duration.inMilliseconds;
          } else {
            _progress = 0.0;
          }

          notifyListeners();
        },
      )

      ///
      ..onPlayerError.listen(
        (msg) {
          debugPrint('audioPlayer error : $msg');
          _progress = 0.0;
          _duration = Duration();
          _position = Duration();
        },
      )

      /// 播放状态监听
      ..onPlayerStateChanged.listen(
        (AudioPlayerState state) {
          _curState = state;
          debugPrint('onPlayerStateChanged===============state: $state');

          if (_curState == AudioPlayerState.COMPLETED) {
            /// 下一首
            nextMusic();
          }

          // 其实也只有在播放状态更新时才需要通知。
          notifyListeners();
        },
      );
  }

  /// 播放指定歌曲
  ///
  /// [index] 歌曲位置【下标】
  ///
  void playSongByIndex(int index) {
    if (curIndex != index) {
      if (isPlaying) {
        _stop();
      }
      curIndex = index;
      _play();
    } else {
      if (!isPlaying) {
        _play();
      }
    }
  }

  /// 播放一首歌
  ///
  /// [song] 播放的歌曲
  ///
  void playSong(Song song) {
    _songs.insert(curIndex, song);
    _play();
  }

  /// 播放很多歌
  ///
  /// [songs] 歌曲列表
  /// [index] 从哪儿开始
  ///
  void playSongs(List<Song> songs, {int index: 0}) {
    this._songs.clear();
    this._songs.addAll(songs);
    if (isPlaying) {
      _stop();
    }
    curIndex = index;
    _play();
  }

  /// 添加歌曲到播放列表
  ///
  /// [songs] 添加的歌曲
  ///
  void addSongs(List<Song> songs) {
    songs.forEach((item) {
      if (!this._songs.contains(item)) {
        this._songs.add(item);
      }
    });
  }

  /// 添加歌曲到播放列表
  ///
  /// [song] 歌曲
  /// [isFirst] 是否放在最前面，默认添加到列表末尾
  ///
  void addSong(Song song, {bool isFirst: false}) {
    if (this._songs.contains(song)) {
      this._songs.remove(song);
    }
    if (isFirst) {
      this._songs.insert(0, song);
    } else {
      this._songs.add(song);
    }
  }

  /// 从播放列表删除歌曲
  ///
  /// [index] 歌曲位置
  ///
  void deleteSong(int index) {
    this._songs.removeAt(index);
    notifyListeners();
  }

  /// 删除播放列表
  ///
  void deleteSongs() {
    if (isPlaying) {
      _stop();
    }
    this._songs.clear();
    notifyListeners();
  }

  /// 播放
  void _play() async {
    _audioPlayer.play("${_songs[curIndex].audioPath}");
  }

  /// 开始、暂停、恢复
  void togglePlay() {
    if (_audioPlayer.state == AudioPlayerState.PAUSED) {
      _resume();
    } else if (_audioPlayer.state == AudioPlayerState.PLAYING) {
      _pause();
    } else {
      _play();
    }
  }

  // 停止
  void _stop() {
    _progress = 0.0;
    _audioPlayer.stop();
    _duration = Duration();
    _position = Duration();
  }

  // 暂停
  void _pause() {
    _audioPlayer.pause();
  }

  /// 跳转到固定时间
  void seekPlay(double progress, {bool resume: true}) {
    this._progress = progress;
    _audioPlayer.seek(
        Duration(milliseconds: (_duration.inMilliseconds * progress).toInt()));
    if (resume) {
      _resume();
    }
  }

  /// 恢复播放
  void _resume() {
    _audioPlayer.resume();
  }

  /// 下一首
  void nextMusic() {
    if (2 == _mode) {
      curIndex = curIndex;
    } else if (0 == _mode) {
      if (curIndex >= _songs.length) {
        curIndex = 0;
      } else {
        curIndex++;
      }
    } else if (1 == _mode) {
      curIndex = Random().nextInt(_songs.length - 1);
    }

    if (_curState != AudioPlayerState.STOPPED) {
      _stop();
    }

    seekPlay(0.0, resume: false);

    Future.delayed(Duration(milliseconds: 500), () {
      _play();
    });
  }

  /// 上一首
  void prePlay() {
    if (2 == _mode) {
      curIndex = curIndex;
    } else if (0 == _mode) {
      if (curIndex <= 0) {
        curIndex = _songs.length - 1;
      } else {
        curIndex--;
      }
    } else if (1 == _mode) {
      curIndex = Random().nextInt(_songs.length - 1);
    }
    if (_curState != AudioPlayerState.STOPPED) {
      _stop();
    }

    seekPlay(0.0, resume: false);

    Future.delayed(Duration(milliseconds: 500), () {
      _play();
    });
  }

  /// 调节音量
  void setVolume(double volume) {
    _audioPlayer.setVolume(volume);
  }

  /// 切换播放顺序
  void toggleMode(int mode) {
    _mode = mode;
    if (mode == 0) {
      _modeIcon = Icons.repeat;
    } else if (mode == 1) {
      _modeIcon = Icons.shuffle;
    } else if (mode == 2) {
      _modeIcon = Icons.repeat_one;
    }

    SpUtil.setInt("song_mode", mode);

    notifyListeners();
  }

  @override
  void dispose() {
    _stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  /// 获取网络音乐列表
  ///
  void getMusics() async {
    List<Song> list = await ApiService.getMusics();

    addSongs(list);
  }
}
