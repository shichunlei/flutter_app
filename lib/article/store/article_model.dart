import 'package:flutter/material.dart';
import '../../page_index.dart';
import '../index.dart';

class ArticleModel with ChangeNotifier {
  ArticleProvider provider;

  ArticleModel() {
    provider = ArticleProvider();
  }

  double getTextSize() {
    double fontSize = SpUtil.getDouble('article_font_size', defValue: 18.0);
    return fontSize;
  }

  int getThemeColorIndex() {
    int themeColorIndex = SpUtil.getInt('themeIndex', defValue: 0);
    return themeColorIndex;
  }

  setTextSize(double textSize) async {
    SpUtil.setDouble('article_font_size', textSize);
    notifyListeners();
  }

  setThemeColorIndex(int themeIndex) async {
    SpUtil.setInt('themeIndex', themeIndex);
    notifyListeners();
  }

  setDate(String date) {
    debugPrint('$date======================================');

    _date = date;

    getStarStatus(date);
  }

  bool _starStatus = false;

  getStarStatus(String date) async {
    _starStatus = await provider.isCollection(date);

    notifyListeners();
  }

  bool get starStatus => _starStatus;

  setStarStatus({Article article}) async {
    if (!_starStatus) {
      /// 收藏
      _starStatus = true;
      provider.insertOrReplaceToDB(article);
    } else {
      /// 取消收藏
      _starStatus = false;
      provider.cancelStarred(article.date.curr);
    }
    notifyListeners();
  }

  String _date = '';

  String get date => _date;
}
