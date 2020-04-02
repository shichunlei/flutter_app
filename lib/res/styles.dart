import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../page_index.dart';

/// 间隔
class Gaps {
  /// 水平间隔
  static Widget hGap3 = SizedBox(width: Dimens.gap_dp3);
  static Widget hGap4 = SizedBox(width: Dimens.gap_dp4);
  static Widget hGap5 = SizedBox(width: Dimens.gap_dp5);
  static Widget hGap6 = SizedBox(width: Dimens.gap_dp6);
  static Widget hGap8 = SizedBox(width: Dimens.gap_dp8);
  static Widget hGap10 = SizedBox(width: Dimens.gap_dp10);
  static Widget hGap12 = SizedBox(width: Dimens.gap_dp12);
  static Widget hGap15 = SizedBox(width: Dimens.gap_dp15);
  static Widget hGap16 = SizedBox(width: Dimens.gap_dp16);
  static Widget hGap20 = SizedBox(width: Dimens.gap_dp20);
  static Widget hGap24 = SizedBox(width: Dimens.gap_dp24);
  static Widget hGap40 = SizedBox(width: Dimens.gap_dp40);

  /// 垂直间隔
  static Widget vGap3 = SizedBox(height: Dimens.gap_dp3);
  static Widget vGap4 = SizedBox(height: Dimens.gap_dp4);
  static Widget vGap5 = SizedBox(height: Dimens.gap_dp5);
  static Widget vGap6 = SizedBox(height: Dimens.gap_dp6);
  static Widget vGap8 = SizedBox(height: Dimens.gap_dp8);
  static Widget vGap10 = SizedBox(height: Dimens.gap_dp10);
  static Widget vGap12 = SizedBox(height: Dimens.gap_dp12);
  static Widget vGap15 = SizedBox(height: Dimens.gap_dp15);
  static Widget vGap16 = SizedBox(height: Dimens.gap_dp16);
  static Widget vGap20 = SizedBox(height: Dimens.gap_dp20);
  static Widget vGap24 = SizedBox(height: Dimens.gap_dp24);
  static Widget vGap25 = SizedBox(height: Dimens.gap_dp25);
  static Widget vGap40 = SizedBox(height: Dimens.gap_dp40);
  static Widget vGap48 = SizedBox(height: Dimens.gap_dp48);
  static Widget vGap60 = SizedBox(height: Dimens.gap_dp60);

  static Widget hGap(double w) {
    return SizedBox(width: w);
  }

  static Widget vGap(double h) {
    return SizedBox(height: h);
  }

  static Widget line = Container(height: 0.6, color: Color(0xFFEEEEEE));
}

class AppTheme {
  static getThemeData(int color) {
    print('getThemeData===================================$color');
    ThemeData themData = ThemeData(
      primaryColor: Color(color == 0 ? Colors.red.value : color),
      fontFamily: 'Aleo',
    );
    return themData;
  }
}

class TextStyles {
  static TextStyle textStyle(
      {double fontSize: Dimens.font_sp12,
      Color color: Colors.white,
      FontWeight fontWeight}) {
    return TextStyle(
        fontSize: fontSize,
        color: color,
        decoration: TextDecoration.none,
        fontWeight: fontWeight);
  }

  static TextStyle textRed12 = textStyle(color: Colors.red);
  static TextStyle textBlue12 = textStyle(color: Colors.blueAccent);
  static TextStyle textWhite12 = textStyle();
  static TextStyle textGreyC12 = textStyle(color: greyCColor);
  static TextStyle textGrey12 = textStyle(color: Colors.grey);
  static TextStyle textDark12 = textStyle(color: grey3Color);
  static TextStyle textBoldDark12 = textStyle(color: Colors.black);
  static TextStyle textBoldWhile12 = textStyle(fontWeight: FontWeight.bold);

  static TextStyle textWhite14 = textStyle(fontSize: Dimens.font_sp14);
  static TextStyle textRed14 =
      textStyle(fontSize: Dimens.font_sp14, color: Colors.red);
  static TextStyle textReader14 =
      textStyle(fontSize: Dimens.font_sp14, color: readerMainColor);
  static TextStyle textBlue14 =
      textStyle(fontSize: Dimens.font_sp14, color: Colors.blueAccent);
  static TextStyle textGreyC14 =
      textStyle(fontSize: Dimens.font_sp14, color: greyCColor);
  static TextStyle textGrey14 =
      textStyle(fontSize: Dimens.font_sp14, color: Colors.grey);
  static TextStyle textDark14 =
      textStyle(fontSize: Dimens.font_sp14, color: grey3Color);
  static TextStyle textBoldDark14 = textStyle(
      fontSize: Dimens.font_sp14,
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle textBoldWhile14 =
      textStyle(fontSize: Dimens.font_sp14, fontWeight: FontWeight.bold);
  static TextStyle textBoldBlue14 = textStyle(
      fontSize: Dimens.font_sp14,
      fontWeight: FontWeight.bold,
      color: Colors.blueAccent);

  static TextStyle textReader16 =
      textStyle(fontSize: Dimens.font_sp16, color: readerMainColor);
  static TextStyle textRed16 =
      textStyle(fontSize: Dimens.font_sp16, color: Colors.red);
  static TextStyle textBlue16 =
      textStyle(fontSize: Dimens.font_sp16, color: Colors.blueAccent);
  static TextStyle textWhite16 = textStyle(fontSize: Dimens.font_sp16);
  static TextStyle textGreyC16 =
      textStyle(fontSize: Dimens.font_sp16, color: greyCColor);
  static TextStyle textGrey16 =
      textStyle(fontSize: Dimens.font_sp16, color: Colors.grey);
  static TextStyle textDark16 =
      textStyle(fontSize: Dimens.font_sp16, color: grey3Color);
  static TextStyle textBoldDark16 = textStyle(
      fontSize: Dimens.font_sp16,
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle textBoldWhile16 = textStyle(
      fontSize: Dimens.font_sp16,
      color: Colors.white,
      fontWeight: FontWeight.bold);

  static TextStyle textBoldDark20 = textStyle(
      fontSize: Dimens.font_sp20,
      color: Colors.black,
      fontWeight: FontWeight.bold);

  static TextStyle textBoldDark26 = textStyle(
      fontSize: Dimens.font_sp26,
      color: Colors.black,
      fontWeight: FontWeight.bold);

  static TextStyle textBoldWhile40 =
      textStyle(fontSize: Dimens.font_sp40, fontWeight: FontWeight.w400);

  static TextStyle textBoldDark40 = textStyle(
      fontSize: Dimens.font_sp40,
      fontWeight: FontWeight.w400,
      color: Colors.black);

  static TextStyle kHintTextStyle = TextStyle(color: Colors.white54);

  static TextStyle kLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
}

final kBoxDecorationStyle = BoxDecoration(
    color: Color(0xFF6CA8F1),
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(color: Colors.black12, blurRadius: 6.0, offset: Offset(0, 2))
    ]);

const IconThemeData lightIconTheme = IconThemeData(color: Colors.black54);
