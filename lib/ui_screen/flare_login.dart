import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'dart:math';

import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_dart/math/vec2d.dart';
import 'package:flutter/rendering.dart';

// Flutter(Flare) 最有趣用户交互动画没有之一 https://juejin.im/post/5effd2145188252e703ab624

class FlareSignInController extends FlareControls {
  ActorNode _faceControl;
  Mat2D _globalToFlareWorld = Mat2D();
  Vec2D _caretGlobal = Vec2D();
  Vec2D _caretWorld = Vec2D();
  Vec2D _faceOrigin = Vec2D();
  Vec2D _faceOriginLocal = Vec2D();
  bool _hasFocus = false;
  String _password;
  static const double _projectGaze = 60.0;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    super.advance(artboard, elapsed);
    Vec2D targetTranslation;
    if (_hasFocus) {
      Vec2D.transformMat2(_caretWorld, _caretGlobal, _globalToFlareWorld);
      _caretWorld[1] +=
          sin(new DateTime.now().millisecondsSinceEpoch / 300.0) * 70.0;

      Vec2D toCaret = Vec2D.subtract(Vec2D(), _caretWorld, _faceOrigin);
      Vec2D.normalize(toCaret, toCaret);
      Vec2D.scale(toCaret, toCaret, _projectGaze);

      Mat2D toFaceTransform = Mat2D();
      if (Mat2D.invert(toFaceTransform, _faceControl.parent.worldTransform)) {
        Vec2D.transformMat2(toCaret, toCaret, toFaceTransform);
        targetTranslation = Vec2D.add(Vec2D(), toCaret, _faceOriginLocal);
      }
    } else {
      targetTranslation = Vec2D.clone(_faceOriginLocal);
    }

    Vec2D diff =
        Vec2D.subtract(Vec2D(), targetTranslation, _faceControl.translation);
    Vec2D frameTranslation = Vec2D.add(Vec2D(), _faceControl.translation,
        Vec2D.scale(diff, diff, min(1.0, elapsed * 5.0)));

    _faceControl.translation = frameTranslation;

    return true;
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    super.initialize(artboard);
    _faceControl = artboard.getNode("ctrl_face");
    if (_faceControl != null) {
      _faceControl.getWorldTranslation(_faceOrigin);
      Vec2D.copy(_faceOriginLocal, _faceControl.translation);
    }
    play("idle");
  }

  @override
  void onCompleted(String name) {
    play("idle");
  }

  @override
  void setViewTransform(Mat2D viewTransform) {
    Mat2D.invert(_globalToFlareWorld, viewTransform);
  }

  void lookAt(Offset caret) {
    if (caret == null) {
      _hasFocus = false;
      return;
    }
    _caretGlobal[0] = caret.dx;
    _caretGlobal[1] = caret.dy;
    _hasFocus = true;
  }

  void setPassword(String value) {
    _password = value;
  }

  bool _isCoveringEyes = false;

  coverEyes(cover) {
    if (_isCoveringEyes == cover) {
      return;
    }
    _isCoveringEyes = cover;
    if (cover) {
      play("hands_up");
    } else {
      play("hands_down");
    }
  }

  void submitPassword() {
    if (_password == "bears") {
      play("success");
    } else {
      play("fail");
    }
  }
}

class FlareLoginPage extends StatefulWidget {
  const FlareLoginPage({Key key}) : super(key: key);

  @override
  createState() => _FlareLoginPageState();
}

class _FlareLoginPageState extends State<FlareLoginPage> {
  FlareSignInController _signInController;

  @override
  void initState() {
    super.initState();

    _signInController = FlareSignInController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Positioned.fill(
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [
              0.0,
              1.0
            ],
                        colors: [
              Color.fromRGBO(255, 193, 7, .6),
              Color.fromRGBO(255, 235, 59, .6)
            ])))),
        Positioned.fill(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 260,
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: FlareActor('images/flare/Teddy.flr',
                          shouldClip: false,
                          alignment: Alignment.bottomCenter,
                          fit: BoxFit.contain,
                          controller: _signInController)),
                  Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                          child: Padding(
                              padding: EdgeInsets.all(30.0),
                              child: Form(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                    TrackingTextInput(
                                        label: 'Email',
                                        hint: 'email address',
                                        onCaretMoved: (Offset caret) {
                                          _signInController.lookAt(caret);
                                        }),
                                    TrackingTextInput(
                                        label: 'Password',
                                        hint: 'Try bears',
                                        isObscured: true,
                                        onCaretMoved: (Offset caret) {
                                          _signInController
                                              .coverEyes(caret != null);
                                          _signInController.lookAt(null);
                                        },
                                        onTextChanged: (String value) {
                                          _signInController.setPassword(value);
                                        }),
                                    Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            gradient:
                                                LinearGradient(colors: <Color>[
                                              Color.fromRGBO(255, 193, 7, .6),
                                              Color.fromRGBO(255, 235, 59, .6),
                                            ])),
                                        child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                                onTap: () => _signInController
                                                    .submitPassword(),
                                                child: Center(
                                                    child: Text('Sign In',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))))))
                                  ])))))
                ]),
          ),
        )
      ]),
    );
  }
}

typedef void CaretMoved(Offset globalCaretPosition);
typedef void TextChanged(String text);

// Helper widget to track caret position.
class TrackingTextInput extends StatefulWidget {
  TrackingTextInput(
      {Key key,
      this.onCaretMoved,
      this.onTextChanged,
      this.hint,
      this.label,
      this.isObscured = false})
      : super(key: key);
  final CaretMoved onCaretMoved;
  final TextChanged onTextChanged;
  final String hint;
  final String label;
  final bool isObscured;

  @override
  _TrackingTextInputState createState() => _TrackingTextInputState();
}

class _TrackingTextInputState extends State<TrackingTextInput> {
  final GlobalKey _fieldKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();
  Timer _debounceTimer;

  @override
  initState() {
    _textController.addListener(() {
      // We debounce the listener as sometimes the caret position is updated after the listener
      // this assures us we get an accurate caret position.
      if (_debounceTimer?.isActive ?? false) _debounceTimer.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        if (_fieldKey.currentContext != null) {
          // Find the render editable in the field.
          final RenderObject fieldBox =
              _fieldKey.currentContext.findRenderObject();
          Offset caretPosition = getCaretPosition(fieldBox);

          if (widget.onCaretMoved != null) {
            widget.onCaretMoved(caretPosition);
          }
        }
      });
      if (widget.onTextChanged != null) {
        widget.onTextChanged(_textController.text);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: TextFormField(
            decoration:
                InputDecoration(hintText: widget.hint, labelText: widget.label),
            key: _fieldKey,
            controller: _textController,
            obscureText: widget.isObscured));
  }

  // Returns first render editable
  RenderEditable findRenderEditable(RenderObject root) {
    RenderEditable renderEditable;
    void recursiveFinder(RenderObject child) {
      if (child is RenderEditable) {
        renderEditable = child;
        return;
      }
      child.visitChildren(recursiveFinder);
    }

    root.visitChildren(recursiveFinder);
    return renderEditable;
  }

  List<TextSelectionPoint> globalize(
      Iterable<TextSelectionPoint> points, RenderBox box) {
    return points.map<TextSelectionPoint>((TextSelectionPoint point) {
      return TextSelectionPoint(
          box.localToGlobal(point.point), point.direction);
    }).toList();
  }

  Offset getCaretPosition(RenderBox box) {
    final RenderEditable renderEditable = findRenderEditable(box);
    if (!renderEditable.hasFocus) {
      return null;
    }
    final List<TextSelectionPoint> endpoints = globalize(
        renderEditable.getEndpointsForSelection(renderEditable.selection),
        renderEditable);
    return endpoints[0].point + const Offset(0.0, -2.0);
  }
}
