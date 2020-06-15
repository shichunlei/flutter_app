import 'package:flutter/material.dart';
import '../../page_index.dart';
import '../index.dart';

class ArticleModel with ChangeNotifier {
  String _today = formatDate(DateTime.now(), formats: [yyyy, mm, dd]);

  ArticleProvider provider;

  LoaderState _status = LoaderState.Loading;

  get status => _status;

  ArticleModel() {
    provider = ArticleProvider();
  }

  setPageStatus(LoaderState status) {
    _status = status;
    notifyListeners();
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

  bool _starStatus = false;

  getStarStatus() async {
    _starStatus = await provider.isCollection(_date);
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
      provider.cancelStarred(article.curr);
    }
    notifyListeners();
  }

  String _date = '';

  String get date => _date;

  Article _article;

  Article get article => _article;

  getArticle(String type, {String date}) async {
    if (type == 'today') {
      _article = await ApiService.getTodayArticle();
    } else if (type == 'random') {
      _article = await ApiService.getRandomArticle();
    } else if (type == 'day') {
      _article = await ApiService.getDayArticle(date);
    }
    _date = article.curr;
    debugPrint(
        '$_today--------------------------------------${_date.toString()}');
    if (_date != _today && type == 'today') {
      _today = _date;
    }

    getStarStatus();

    _status = LoaderState.Succeed;
    notifyListeners();
  }

  String get today => _today;
}
