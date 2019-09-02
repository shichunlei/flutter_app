import 'package:flutter/material.dart';
import 'package:custom_widgets/custom_widgets.dart';

class FlipViewCustom extends StatefulWidget {
  FlipViewCustom({Key key}) : super(key: key);

  @override
  createState() => _FlipViewCustomState();
}

class _FlipViewCustomState extends State<FlipViewCustom>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _curvedAnimation;

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.addStatusListener((AnimationStatus status) {
      if (!_focusNode.hasFocus && _animationController.isCompleted) {
        setState(() {
          FocusScope.of(context).requestFocus(_focusNode);
          print('complete  ${_focusNode.hasFocus}');
        });
      } else if (_focusNode.hasFocus && !_animationController.isCompleted) {
        _focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _flip(bool reverse) {
    if (_animationController.isAnimating) return;
    if (reverse) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: FlipView(
              animationController: _curvedAnimation,
              front: _buildFrontSide(),
              back: _buildBackSide(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFrontSide() {
    return AspectRatio(
      aspectRatio: 1.6,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'You Received a  Meesage',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Divider(height: 1, color: Colors.grey),
            ),
            Expanded(
              child: Center(
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(text: 'Your verify code is: '),
                    TextSpan(
                        text: 'EDIHK',
                        style: TextStyle(
                            fontSize: 15, color: Colors.teal.shade800)),
                  ], style: TextStyle(fontSize: 15, color: Colors.black87)),
                ),
              ),
            ),
            Divider(height: 1, color: Colors.grey),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                onTap: () {
                  _flip(true);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Click to Check Text',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackSide() {
    return Card(
      color: Colors.grey.shade50,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Enter Password Or Verify Fingerprint ID',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 32, right: 32, bottom: 24),
            color: Colors.white,
            child: TextField(
              focusNode: _focusNode,
              textAlign: TextAlign.center,
              cursorColor: Colors.black38,
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  highlightColor: Colors.grey.withOpacity(0.2),
                  splashColor: Colors.grey.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Back', textAlign: TextAlign.center),
                  ),
                  onTap: () {
                    _flip(false);
                  },
                ),
              ),
              Container(
                width: 1,
                height: 46,
                color: Colors.grey.withOpacity(0.4),
              ),
              Expanded(
                child: InkWell(
                  highlightColor: Colors.grey.withOpacity(0.2),
                  splashColor: Colors.grey.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Ok', textAlign: TextAlign.center),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
