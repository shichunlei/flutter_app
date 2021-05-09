// import 'dart:async';
//
// import 'package:flutter_libs/flutter_libs.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app/utils/file_util.dart';
// import 'package:flutter_sound/flutter_sound.dart';
//
// class RecorderDemo extends StatefulWidget {
//   RecorderDemo({Key key}) : super(key: key);
//
//   @override
//   createState() => _RecorderDemoState();
// }
//
// class _RecorderDemoState extends State<RecorderDemo>
//     with TickerProviderStateMixin {
//   AnimationController _controller;
//
//   FlutterSound _flutterSound;
//
//   StreamSubscription recorderSubscription;
//   StreamSubscription recorderDbPeakSubscription;
//
//   //音频播放的监听
//   StreamSubscription playSubscription;
//
//   String audioPath;
//
//   String audioFileName;
//
//   List<int> waveData = [];
//
//   double volume = .0;
//
//   //语音播放的动画controller
//   AnimationController audioController;
//
//   bool isForward = false;
//
//   int audioDuration = 0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     init();
//
//     _flutterSound = FlutterSound();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("RecordDemo")),
//         body: Container(
//           child: Column(children: <Widget>[
//             GestureDetector(
//                 behavior: HitTestBehavior.opaque,
//                 onTapUp: (_) {
//                   stopRecorder();
//                 },
//                 onTapDown: (_) {
//                   startRecorder();
//                 },
//                 child: Container(
//                     height: 100,
//                     child: Text("录音"),
//                     width: double.infinity,
//                     alignment: Alignment.center)),
//             SizedBox(height: 50),
//             waveData.length > 0
//                 ? Container(
//                     decoration: BoxDecoration(
//                         color: Color(0xff666666),
//                         borderRadius: BorderRadius.all(Radius.circular(40))),
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     margin: EdgeInsets.symmetric(horizontal: 20),
//                     child: Row(children: <Widget>[
//                       IconButton(
//                           icon: Icon(
//                               t_AUDIO_STATE.IS_PLAYING ==
//                                       _flutterSound.audioState
//                                   ? Icons.pause
//                                   : Icons.play_arrow,
//                               color: Colors.white),
//                           onPressed: () {
//                             play(audioPath);
//                           }),
//                       Expanded(
//                           child: CustomPaint(
//                               painter: LineBarVisualizer(
//                                   waveData: waveData,
//                                   progressValue: _controller == null ||
//                                           t_AUDIO_STATE.IS_PLAYING !=
//                                               _flutterSound.audioState
//                                       ? 0
//                                       : _controller.value,
//                                   progressColor: Color(0xff4DBA83),
//                                   height: 25,
//                                   width: 200,
//                                   color: Color(0xffF8FDFB)))),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text('${getDurationStr(audioDuration)}\'',
//                             style: TextStyle(
//                                 color: Color(0xff14D16B), fontSize: 12)),
//                       )
//                     ]),
//                   )
//                 : SizedBox(),
// //            Container(
// //                color: Colors.grey,
// //                height: 184,
// //                child: AudioRecorder(
// //                    waveColor: "#1BCF8A",
// //                    onCreated: (AudioRecorderController value) =>
// //                        audioRecorderController = value))
//           ]),
//         ));
//   }
//
//   String getDurationStr(int milliseconds) {
//     if (milliseconds == null) return '';
//     int seconds = (milliseconds / 1000).truncate();
//     String secondsStr = (seconds % 60).toString().padLeft(2, '');
//     return secondsStr;
//   }
//
//   void init() async {
//     String path = await FileUtil.getInstance().getTempPath();
//     if (defaultTargetPlatform == TargetPlatform.android) {
//       audioFileName = "audio.mp3";
//       audioPath = '$path$audioFileName';
//     } else {
//       audioFileName = "audio.m4a";
//       audioPath = '$path$audioFileName';
//     }
//
//     FileUtil.getInstance().deleteFile(audioPath);
//   }
//
//   // 开始录制
//   Future startRecorder() async {
//     try {
//       waveData.clear();
//       await _flutterSound.startRecorder(uri: audioPath);
//       print('startRecorder------------');
//       initRecorderSubscription();
//     } catch (err) {
//       print('startRecorder error: $err');
//     }
//   }
//
//   void initRecorderSubscription() {
//     recorderSubscription = _flutterSound.onRecorderStateChanged.listen((e) {
//       audioDuration = e.currentPosition.toInt();
//
//       print("-----------------------------$audioDuration");
//
//       setState(() {});
//     });
//
//     recorderDbPeakSubscription =
//         _flutterSound.onRecorderDbPeakChanged.listen((double value) {
//       if (value == null) volume = 0.0;
//       volume = value;
//     });
//   }
//
//   // 停止录制
//   Future stopRecorder() async {
//     try {
//       String audioPath = await _flutterSound.stopRecorder();
//       print('停止录制-----------');
//       if (recorderSubscription != null) {
//         recorderSubscription.cancel();
//         recorderSubscription = null;
//       }
//       if (recorderDbPeakSubscription != null) {
//         recorderDbPeakSubscription.cancel();
//         recorderDbPeakSubscription = null;
//       }
//
//       List<int> data = await FileUtil.getInstance().readFileByte(audioPath);
//       waveData = data;
//
//       print("=======================================${waveData.length}");
//
//       setState(() {});
//     } catch (err) {
//       print('stopRecorder error: $err');
//     }
//   }
//
//   void play(String audioUri, {bool isNetworkUrl = false}) async {
//     if (t_AUDIO_STATE.IS_PLAYING == _flutterSound.audioState) {
//       await stopPlay();
//     }
//     await _flutterSound.startPlayer(audioUri);
//
//     initPlaySubscription();
//     setState(() {});
//   }
//
//   void initPlaySubscription() {
//     playSubscription =
//         _flutterSound.onPlayerStateChanged.listen((PlayStatus playStatus) {
//       if (playStatus != null && playStatus.currentPosition != null) {
//         print(
//             '当前音频的播放位置 = ${playStatus.currentPosition}，总时长=${playStatus.duration}');
//         if (_controller == null &&
//             t_AUDIO_STATE.IS_PLAYING == _flutterSound.audioState) {
//           _controller = AnimationController(
//               duration: Duration(milliseconds: playStatus.duration.toInt()),
//               vsync: this);
//           _controller.forward();
//         }
//         if (t_AUDIO_STATE.IS_PLAYING == _flutterSound.audioState &&
//             !isForward) {
//           isForward = true;
//           audioController.repeat();
//         }
//         if (playStatus.currentPosition >= playStatus.duration) {
//           clearAudioData();
//         }
//
//         setState(() {});
//       }
//     });
//   }
//
//   void clearAudioData() {
//     print('播放停止...');
//     if (_controller != null) {
//       _controller.dispose();
//       _controller = null;
//     }
//
//     if (playSubscription != null) {
//       playSubscription.cancel();
//       playSubscription = null;
//     }
//
//     isForward = false;
//     audioController.stop();
//
//     setState(() {});
//   }
//
//   // 停止播放音频
//   Future stopPlay() async {
//     if (t_AUDIO_STATE.IS_PLAYING == _flutterSound.audioState) {
//       await _flutterSound.stopPlayer();
//       clearAudioData();
//     }
//   }
//
// //  AudioRecorderController audioRecorderController;
// //
// //  void startRecord() async {
// //    try {
// //      audioRecorderController?.start();
// //      print('开始录制------------');
// //    } catch (err) {
// //      print('startRecorder error: $err');
// //
// //      await audioRecorderController?.stop();
// //    }
// //  }
// //
// //  void stopRecord() async {
// //    print('录制完成');
// //
// //    if (audioRecorderController != null) {
// //      Recording recording = await audioRecorderController.stop();
// //
// //      if (recording != null) {
// //        print('录音结果：${recording.duration.toString()}====${recording.fileName}');
// //        audioPath = recording.fileName;
// //
// //        audioDuration = recording.duration.inMilliseconds;
// //
// //        print(
// //            '录制成功---------------------$audioPath----------------$audioDuration');
// //      }
// //    } else {}
// //  }
// }
