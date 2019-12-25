import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'data.dart';

enum SummaryTheme { dark, light }

class FlightSummary extends StatelessWidget {
  final BoardingPassData boardingPass;
  final SummaryTheme theme;
  final bool isOpen;

  const FlightSummary({
    Key key,
    this.boardingPass,
    this.theme = SummaryTheme.light,
    this.isOpen = false,
  }) : super(key: key);

  Color get mainTextColor {
    Color textColor;
    if (theme == SummaryTheme.dark) textColor = Colors.white;
    if (theme == SummaryTheme.light) textColor = Color(0xFF083e64);
    return textColor;
  }

  Color get secondaryTextColor {
    Color textColor;
    if (theme == SummaryTheme.dark) textColor = Color(0xff61849c);
    if (theme == SummaryTheme.light) textColor = Color(0xFF838383);
    return textColor;
  }

  Color get separatorColor {
    Color color;
    if (theme == SummaryTheme.light) color = Color(0xffeaeaea);
    if (theme == SummaryTheme.dark) color = Color(0xff396583);
    return color;
  }

  TextStyle get bodyTextStyle => TextStyle(color: mainTextColor, fontSize: 13);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getBackgroundDecoration(),
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildLogoHeader(),
            Container(width: double.infinity, height: 1, color: separatorColor),
            _buildTicketHeader(context),
            Row(
              children: <Widget>[
                _buildTicketOrigin(),
                Expanded(child: _buildTicketDuration()),
                _buildTicketDestination()
              ],
            ),
            Icon(
                theme == SummaryTheme.light
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_up,
                color: mainTextColor,
                size: 18)
          ],
        ),
      ),
    );
  }

  _getBackgroundDecoration() {
    if (theme == SummaryTheme.light)
      return BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
      );
    if (theme == SummaryTheme.dark)
      return BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        image: DecorationImage(
            image: AssetImage('images/bg_blue.png'), fit: BoxFit.cover),
      );
  }

  _buildLogoHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: theme == SummaryTheme.light
              ? Image.asset('images/flutterlogo.png', width: 8)
              : Image.asset(
                  'images/flutterlogo.png',
                  width: 8,
                  color: Colors.white,
                ),
        ),
        Text('boarding pass'.toUpperCase(),
            style: TextStyle(
                color: mainTextColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5))
      ],
    );
  }

  Widget _buildTicketHeader(context) {
    var headerStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFFe46565));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(boardingPass.passengerName.toUpperCase(), style: headerStyle),
        Text('BOARDING ${boardingPass.boardingTime.format(context)}',
            style: headerStyle),
      ],
    );
  }

  Widget _buildTicketOrigin() {
    return Column(
      children: <Widget>[
        Text(
          boardingPass.origin.code.toUpperCase(),
          style: bodyTextStyle.copyWith(fontSize: 42),
        ),
        Text(boardingPass.origin.city,
            style: bodyTextStyle.copyWith(color: secondaryTextColor)),
      ],
    );
  }

  Widget _buildTicketDuration() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: 120,
            height: 58,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset(
                  'images/planeroute_white.png',
                  fit: BoxFit.fitWidth,
                  color: theme == SummaryTheme.dark
                      ? Colors.white
                      : Colors.blueGrey,
                ),
                if (theme == SummaryTheme.light)
                  _rotateIcon(
                      iconData: Icons.flight,
                      angle: math.pi / 2,
                      iconColor: Colors.blueGrey),
                if (theme == SummaryTheme.dark)
                  _AnimatedSlideToRight(
                    child: _rotateIcon(
                        iconData: Icons.flight,
                        angle: math.pi / 2,
                        iconColor: Colors.white),
                    isOpen: isOpen,
                  )
              ],
            ),
          ),
          Text(boardingPass.duration.toString(),
              textAlign: TextAlign.center, style: bodyTextStyle),
        ],
      ),
    );
  }

  Widget _rotateIcon({IconData iconData, double angle, Color iconColor}) {
    return Transform.rotate(
        child: Icon(iconData, color: iconColor), angle: angle);
  }

  Widget _buildTicketDestination() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          boardingPass.destination.code.toUpperCase(),
          style: bodyTextStyle.copyWith(fontSize: 42),
        ),
        Text(
          boardingPass.destination.city,
          style: bodyTextStyle.copyWith(color: secondaryTextColor),
        ),
      ],
    );
  }
}

class _AnimatedSlideToRight extends StatefulWidget {
  final Widget child;
  final bool isOpen;

  const _AnimatedSlideToRight({Key key, this.child, @required this.isOpen})
      : super(key: key);

  @override
  createState() => _AnimatedSlideToRightState();
}

class _AnimatedSlideToRightState extends State<_AnimatedSlideToRight>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1700));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isOpen) _controller.forward(from: 0);
    return SlideTransition(
      position: Tween(begin: Offset(-2, 0), end: Offset(1, 0)).animate(
          CurvedAnimation(curve: Curves.easeOutQuad, parent: _controller)),
      child: widget.child,
    );
  }
}
