import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SoundDemo extends StatefulWidget {
  SoundDemo({Key key}) : super(key: key);

  @override
  createState() => _SoundDemoState();
}

class _SoundDemoState extends State<SoundDemo> {
  bool _isRecording = false;
  String _path;
  StreamSubscription _recorderSubscription;
  StreamSubscription _dbPeakSubscription;
  StreamSubscription _playerSubscription;
  FlutterSound flutterSound;

  String _recorderTxt = '0:00:00';
  String _playerTxt = '0:00:00';
  double _dbLevel;

  double sliderCurrentPosition = 0.0;
  double maxDuration = 1.0;

  @override
  void initState() {
    super.initState();

    flutterSound = FlutterSound();
    flutterSound.setSubscriptionDuration(0.01);
    flutterSound.setDbPeakLevelUpdate(0.8);
    flutterSound.setDbLevelEnabled(true);
  }

  void startRecorder() async {
    try {
      String path = await flutterSound.startRecorder();
      print('startRecorder: $path');

      _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
        this.setState(() {
          this._recorderTxt = Utils.duration2String(
              Duration(milliseconds: e.currentPosition.toInt()));
        });
      });
      _dbPeakSubscription =
          flutterSound.onRecorderDbPeakChanged.listen((value) {
        print("got update -> $value");
        setState(() {
          this._dbLevel = value;
        });
      });

      this.setState(() {
        this._isRecording = true;
        this._path = path;
      });
    } catch (err) {
      print('startRecorder error: $err');
      setState(() {
        this._isRecording = false;
      });
    }
  }

  void stopRecorder() async {
    try {
      String result = await flutterSound.stopRecorder();
      print('stopRecorder: $result');

      if (_recorderSubscription != null) {
        _recorderSubscription.cancel();
        _recorderSubscription = null;
      }
      if (_dbPeakSubscription != null) {
        _dbPeakSubscription.cancel();
        _dbPeakSubscription = null;
      }

      this.setState(() {
        this._isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  void startPlayer() async {
    try {
      String path = await flutterSound.startPlayer(this._path);
      await flutterSound.setVolume(1.0);
      print('startPlayer: $path');

      _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
        if (e != null) {
          sliderCurrentPosition = e.currentPosition;
          maxDuration = e.duration;

          this.setState(() {
            //this._isPlaying = true;
            this._playerTxt = Utils.duration2String(
                Duration(milliseconds: sliderCurrentPosition.toInt()));
          });
        }
      });
    } catch (err) {
      print('error: $err');
    }
  }

  void stopPlayer() async {
    try {
      String result = await flutterSound.stopPlayer();
      print('stopPlayer: $result');
      if (_playerSubscription != null) {
        _playerSubscription.cancel();
        _playerSubscription = null;
      }

      this.setState(() {
        //this._isPlaying = false;
      });
    } catch (err) {
      print('error: $err');
    }
  }

  void pausePlayer() async {
    String result = await flutterSound.pausePlayer();
    print('pausePlayer: $result');
  }

  void resumePlayer() async {
    String result = await flutterSound.resumePlayer();
    print('resumePlayer: $result');
  }

  void seekToPlayer(int milliSecs) async {
    String result = await flutterSound.seekToPlayer(milliSecs);
    print('seekToPlayer: $result');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('')),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 24.0, bottom: 16.0),
                child: Text(
                  this._recorderTxt,
                  style: TextStyle(
                    fontSize: 48.0,
                    color: Colors.black,
                  ),
                ),
              ),
              _isRecording
                  ? LinearProgressIndicator(
                      value: 100.0 / 160.0 * (this._dbLevel ?? 1) / 100,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      backgroundColor: Colors.red,
                    )
                  : Container()
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 56.0,
                height: 56.0,
                child: ClipOval(
                  child: FlatButton(
                    onPressed: () {
                      if (!this._isRecording) {
                        return this.startRecorder();
                      }
                      this.stopRecorder();
                    },
                    padding: EdgeInsets.all(8.0),
                    child:
                        Icon(this._isRecording ? Ionicons.md_mic : Icons.stop),
                  ),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 60.0, bottom: 16.0),
                child: Text(
                  this._playerTxt,
                  style: TextStyle(
                    fontSize: 48.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 56.0,
                height: 56.0,
                child: ClipOval(
                  child: FlatButton(
                    onPressed: () {
                      startPlayer();
                    },
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.play_arrow),
                  ),
                ),
              ),
              Container(
                width: 56.0,
                height: 56.0,
                child: ClipOval(
                  child: FlatButton(
                    onPressed: () {
                      pausePlayer();
                    },
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.pause),
                  ),
                ),
              ),
              Container(
                width: 56.0,
                height: 56.0,
                child: ClipOval(
                  child: FlatButton(
                    onPressed: () {
                      stopPlayer();
                    },
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.stop),
                  ),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          Container(
              height: 56.0,
              child: Slider(
                  value: sliderCurrentPosition,
                  min: 0.0,
                  max: maxDuration,
                  onChanged: (double value) async {
                    await flutterSound.seekToPlayer(value.toInt());
                  },
                  divisions: maxDuration.toInt()))
        ],
      ),
    );
  }
}
