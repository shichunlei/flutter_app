import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/music.dart';

import '../../page_index.dart';

class MusicModel extends ChangeNotifier {
  AudioPlayer _audioPlayer;

  AudioPlayerState _curState;

  List<Music> _songs = [];

  List<Music> get allSongs => _songs;

  int curIndex = 0;

  /// 总时长
  Duration _duration;

  Duration get duration => _duration;

  Duration _position;

  String get durationText => Utils.duration2String(_duration);

  String get positionText => Utils.duration2String(_position);

  CycleMode _mode;
  IconData _modeIcon;

  CycleMode get mode => _mode;

  IconData get modeIcon => _modeIcon;

  double _progress = 0.0;

  double get progress => _progress;

  bool get isPlaying => _curState == AudioPlayerState.PLAYING;

  Music get curSong => _songs.length == 0 ? null : _songs[curIndex];

  void init() {
    _mode = CycleMode.SEQUENCE;
    _modeIcon = Icons.repeat;

    addSongs(songsData);

    _audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER)
      ..setReleaseMode(ReleaseMode.RELEASE)

      ///
      ..onDurationChanged.listen(
        (Duration duration) {
          debugPrint('onDurationChanged===============Max duration: $duration');
          _duration = duration;
        },
      )

      /// 当前播放进度监听
      ..onAudioPositionChanged.listen(
        (Duration position) {
          debugPrint(
              'onAudioPositionChanged===============position: $position');
          _position = position;

          if (_duration != null) {
            _progress = _position.inMilliseconds / _duration.inMilliseconds;
          }

          notifyListeners();
        },
      )

      ///
      ..onPlayerError.listen(
        (msg) {
          debugPrint('audioPlayer error : $msg');
          _duration = Duration(seconds: 0);
          _position = Duration(seconds: 0);
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

  // 播放指定一首歌
  void playSongByIndex(int index) {
    if (curIndex != index) {
      if (isPlaying) {
        stopPlay();
      }
      curIndex = index;
      play();
    } else {
      if (!isPlaying) {
        play();
      }
    }
  }

  // 播放一首歌
  void playSong(Music song) {
    _songs.insert(curIndex, song);
    play();
  }

  // 播放很多歌
  void playSongs(List<Music> songs, {int index}) {
    this._songs = songs;
    if (index != null) curIndex = index;
    play();
  }

  // 添加歌曲
  void addSongs(List<Music> songs) {
    this._songs.addAll(songs);
  }

  /// 播放
  void play() {
    _audioPlayer.play("${_songs[curIndex].audioPath}");
  }

  /// 暂停、恢复
  void togglePlay() {
    if (_position == null) {
      play();
    } else {
      if (_audioPlayer.state == AudioPlayerState.PAUSED) {
        resumePlay();
      } else {
        pausePlay();
      }
    }
  }

  // 停止
  void stopPlay() {
    _audioPlayer.stop();
  }

  // 暂停
  void pausePlay() {
    _audioPlayer.pause();
  }

  /// 跳转到固定时间
  void seekPlay(int milliseconds, {bool resume: true}) {
    _audioPlayer.seek(Duration(milliseconds: milliseconds));
    if (resume) {
      resumePlay();
    }
  }

  /// 恢复播放
  void resumePlay() {
    _audioPlayer.resume();
  }

  /// 下一首
  void nextMusic() {
    if (CycleMode.SINGLE == _mode) {
      curIndex = curIndex;
    } else if (CycleMode.SEQUENCE == _mode) {
      if (curIndex >= _songs.length) {
        curIndex = 0;
      } else {
        curIndex++;
      }
    } else if (CycleMode.RANDOM == _mode) {
      curIndex = Random().nextInt(_songs.length - 1);
    }

    if (_curState != AudioPlayerState.STOPPED) {
      stopPlay();
    }

    seekPlay(0, resume: false);

    Future.delayed(Duration(milliseconds: 500), () {
      play();
    });
  }

  /// 上一首
  void prePlay() {
    if (CycleMode.SINGLE == _mode) {
      curIndex = curIndex;
    } else if (CycleMode.SEQUENCE == _mode) {
      if (curIndex <= 0) {
        curIndex = _songs.length - 1;
      } else {
        curIndex--;
      }
    } else if (CycleMode.RANDOM == _mode) {
      curIndex = Random().nextInt(_songs.length - 1);
    }
    if (_curState != AudioPlayerState.STOPPED) {
      stopPlay();
    }

    seekPlay(0, resume: false);

    Future.delayed(Duration(milliseconds: 500), () {
      play();
    });
  }

  /// 调节音量
  void setVolume(double volume) {
    _audioPlayer.setVolume(volume);
  }

  /// 切换播放顺序
  void toggleMode(CycleMode mode) {
    _mode = mode;
    if (mode == CycleMode.SEQUENCE) {
      _modeIcon = Icons.repeat;
    } else if (mode == CycleMode.RANDOM) {
      _modeIcon = Icons.shuffle;
    } else if (mode == CycleMode.SINGLE) {
      _modeIcon = Icons.repeat_one;
    }

    notifyListeners();
  }

  @override
  void dispose() {
    stopPlay();
    _audioPlayer.dispose();
    super.dispose();
  }
}
