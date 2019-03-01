import 'dart:math';

import 'package:flutter/material.dart';

import 'package:rounded_letter/click_listener.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

class RoundedLetterWidget extends StatefulWidget {
  @override
  _RoundedLetterWidgetState createState() => _RoundedLetterWidgetState();
}

class _RoundedLetterWidgetState extends State<RoundedLetterWidget> {
  _RoundedLetterWidgetState() {
    names.add("Tom");
    names.add("Mike");
    names.add("Bob");
    names.add("Ross");
    names.add("Joey");
    names.add("Thomas");
    names.add("Harry");
    names.add("Percy");
    names.add("Yvone");
    names.add("Xavier");
    names.add("Zac");
    surnames.add("Callinan");
    surnames.add("Mcgrath");
    surnames.add("Luster");
    surnames.add("Kasten");
    surnames.add("Maione");
    surnames.add("Heyeck");
  }

  Random _random = Random();
  List<String> names = List();
  List<String> surnames = List();
  SampleClickListener listener = SampleClickListener();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rounded Letter'),
        ),
        body: Container(child: getListWithRoundedLetters()));
  }

  Widget getListWithRoundedLetters() {
    List<Widget> widgets = List();
    widgets.addAll(buildDivider("Rectangles", "Example rectangle shapes"));
    widgets.add(_getRowWith(ShapeType.rectangle));
    widgets.addAll(buildDivider("Triangles", "Example triangle shapes"));
    widgets.add(_getRowWith(ShapeType.triangle));
    widgets.addAll(buildDivider("Pentagons", "Example pentagon shapes"));
    widgets.add(_getRowWith(ShapeType.pentagon));
    widgets.addAll(buildDivider("Hexagons", "Example hexagon shapes"));
    widgets.add(_getRowWith(ShapeType.hexagon));
    widgets.addAll(
        buildDivider("Italic/bold", "Example shapes with italic/bold text"));
    widgets.add(_getRowWithDifferentFontStyles());
    widgets.addAll(buildDivider("Clickable element",
        "Example clickable shape. Click result is printed to console"));
    widgets.add(_getRowWith(ShapeType.circle));
    widgets.addAll(buildDivider("Default circles", "Example circles"));
    for (var i = 0; i < 50; i++) {
      widgets.add(getRow());
    }
    return ListView(children: widgets);
  }

  List<Widget> buildDivider(String text, String subtitle) {
    List<Widget> widgets = List();

    widgets.add(Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)));
    widgets.add(Center(child: Text(text, style: TextStyle(fontSize: 20))));
    widgets.add(Center(child: Text(subtitle, style: TextStyle(fontSize: 12))));
    widgets.add(Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)));
    widgets.add(Container(child: CustomPaint(painter: DividerPainter())));
    widgets.add(Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)));
    return widgets;
  }

  Widget _getRowWith(ShapeType shapeType) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
            RoundedLetter(
              text: "JH",
              shapeColor: Color(0xFFF4511E),
              shapeType: shapeType,
              borderColor: Color(0xFFBF360C),
              borderWidth: 1,
              fontBold: true,
              key: Key("Rectangle1"),
              clickListener: listener,
            ),
            RoundedLetter(
              text: "Mw",
              shapeColor: Color(0xFF689F38),
              shapeType: shapeType,
              borderColor: Color(0xFF33691E),
              borderWidth: 1,
              fontBold: true,
              fontItalic: true,
              fontSize: 15,
            ),
            RoundedLetter(
              text: "O",
              shapeColor: Color(0xFF00897B),
              shapeType: shapeType,
              borderColor: Color(0xFF004D40),
              borderWidth: 1,
            ),
            RoundedLetter(
              text: "X",
              shapeColor: Color(0xFF5E35B1),
              shapeType: shapeType,
              borderColor: Color(0xFF311B92),
              borderWidth: 1,
              fontItalic: true,
            ),
            RoundedLetter(
              text: "CL",
              shapeColor: Color(0xFFF4511E),
              shapeType: shapeType,
              borderColor: Color(0xFFBF360C),
              borderWidth: 1,
              shapeSize: 80,
              fontSize: 40,
              fontBold: true,
              key: Key("clickable_circle"),
              clickListener: SampleClickListener(),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
          ],
        ));
  }

  Widget _getRowWithDifferentFontStyles() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
            RoundedLetter(
              text: "AB",
              shapeColor: Color(0xFFF4511E),
              shapeType: ShapeType.circle,
              borderColor: Color(0xFFBF360C),
              borderWidth: 1,
              fontBold: true,
            ),
            RoundedLetter(
              text: "Ac",
              shapeColor: Color(0xFF689F38),
              shapeType: ShapeType.rectangle,
              borderColor: Color(0xFF33691E),
              borderWidth: 1,
              fontItalic: true,
            ),
            RoundedLetter(
              text: "O",
              shapeColor: Color(0xFF039BE5),
              shapeType: ShapeType.triangle,
              borderColor: Color(0xFF01579B),
              borderWidth: 1,
              fontBold: true,
              fontItalic: true,
            ),
            RoundedLetter(
              text: "N",
              shapeColor: Color(0xFF00897B),
              shapeType: ShapeType.pentagon,
              borderColor: Color(0xFF004D40),
              borderWidth: 1,
              fontBold: true,
            ),
            RoundedLetter(
              text: "r",
              shapeColor: Color(0xFF5E35B1),
              shapeType: ShapeType.hexagon,
              borderColor: Color(0xFF311B92),
              borderWidth: 1,
              fontItalic: true,
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
          ],
        ));
  }

  Widget getRow() {
    var name = _getRandomName();
    var surname = _getRandomSurname();
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: Row(children: <Widget>[
          Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 0)),
          _getRandomColorRoundedLetter(name.substring(0, 1).toUpperCase()),
          Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
          Text(name + " " + surname)
        ]));
  }

  String _getRandomName() {
    return names[_random.nextInt(names.length)];
  }

  String _getRandomSurname() {
    return surnames[_random.nextInt(surnames.length)];
  }

  RoundedLetter _getRandomColorRoundedLetter(String letter) {
    RoundedLetter roundedLetter;
    switch (_random.nextInt(4)) {
      case 0:
        roundedLetter = RoundedLetter.withRedCircle(letter, 40, 20);
        break;
      case 1:
        roundedLetter = RoundedLetter.withGreenCircle(letter, 40, 20);
        break;
      case 2:
        roundedLetter = RoundedLetter.withBlueCircle(letter, 40, 20);
        break;
      default:
        roundedLetter = RoundedLetter.withRandomColors(letter, 40, 20);
    }
    return roundedLetter;
  }
}

class SampleClickListener extends ClickListener {
  @override
  onClick(Key key) {
    print("Clicked on " + key.toString());
  }
}

class DividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint..color = Color(0xFF424242);
    paint..strokeWidth = 1;
    return canvas.drawLine(Offset(40, 0), Offset(size.width - 40, 0), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
