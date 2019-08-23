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
  static Widget vGap60 = SizedBox(height: Dimens.gap_dp60);

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
  static const TextStyle textRed12 =
      TextStyle(fontSize: Dimens.font_sp12, color: Colors.red);
  static const TextStyle textBlue12 =
      TextStyle(fontSize: Dimens.font_sp12, color: Colors.blueAccent);
  static const TextStyle textWhite12 =
      TextStyle(fontSize: Dimens.font_sp12, color: Colors.white);
  static const TextStyle textGrayC12 =
      TextStyle(fontSize: Dimens.font_sp12, color: Color(0xFFcccccc));
  static const TextStyle textGray12 =
      TextStyle(fontSize: Dimens.font_sp12, color: Colors.grey);
  static const TextStyle textDark12 =
      TextStyle(fontSize: Dimens.font_sp12, color: Color(0xFF333333));
  static const TextStyle textBoldDark12 = TextStyle(
      fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold);
  static const TextStyle textBoldWhile12 = TextStyle(
      fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.bold);

  static const TextStyle textWhite14 =
      TextStyle(fontSize: Dimens.font_sp14, color: Colors.white);
  static const TextStyle textRed14 =
      TextStyle(fontSize: Dimens.font_sp14, color: Colors.red);
  static const TextStyle textReader14 =
      TextStyle(fontSize: Dimens.font_sp14, color: readerMainColor);
  static const TextStyle textBlue14 =
      TextStyle(fontSize: Dimens.font_sp14, color: Colors.blueAccent);
  static const TextStyle textGrayC14 =
      TextStyle(fontSize: Dimens.font_sp14, color: Color(0xFFcccccc));
  static const TextStyle textGray14 =
      TextStyle(fontSize: Dimens.font_sp14, color: Colors.grey);
  static const TextStyle textDark14 =
      TextStyle(fontSize: Dimens.font_sp14, color: Color(0xFF333333));
  static const TextStyle textBoldDark14 = TextStyle(
      fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold);
  static const TextStyle textBoldWhile14 = TextStyle(
      fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold);

  static const TextStyle textReader16 =
      TextStyle(fontSize: Dimens.font_sp16, color: readerMainColor);
  static const TextStyle textRed16 =
      TextStyle(fontSize: Dimens.font_sp16, color: Colors.red);
  static const TextStyle textBlue16 =
      TextStyle(fontSize: Dimens.font_sp16, color: Colors.blueAccent);
  static const TextStyle textWhite16 =
      TextStyle(fontSize: Dimens.font_sp16, color: Colors.white);
  static const TextStyle textGrayC16 =
      TextStyle(fontSize: Dimens.font_sp16, color: Color(0xFFcccccc));
  static const TextStyle textGray16 =
      TextStyle(fontSize: Dimens.font_sp16, color: Colors.grey);
  static const TextStyle textDark16 =
      TextStyle(fontSize: Dimens.font_sp16, color: Color(0xFF333333));
  static const TextStyle textBoldDark16 = TextStyle(
      fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold);
  static const TextStyle textBoldWhile16 = TextStyle(
      fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold);

  static const TextStyle textBoldDark20 = TextStyle(
      fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold);

  static const TextStyle textBoldDark26 = TextStyle(
      fontSize: 26.0, color: Colors.black, fontWeight: FontWeight.bold);

  static const TextStyle textBoldWhile40 = TextStyle(
      fontSize: 40.0, color: Colors.white, fontWeight: FontWeight.w400);
}

const IconThemeData lightIconTheme = IconThemeData(color: Colors.black54);
