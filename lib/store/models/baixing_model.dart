import 'package:flutter/material.dart';

class BaixingModel extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  setPageIndex(int index) {
    _currentPage = index;

    notifyListeners();
  }

  int _categoryIndex = 0;

  int get categoryIndex => _categoryIndex;

  int _subCategoryIndex = 0;

  int get subCategoryIndex => _subCategoryIndex;

  setCategories(int categoryIndex, int subCategoryIndex) {
    _categoryIndex = categoryIndex;
    _subCategoryIndex = subCategoryIndex;

    notifyListeners();
  }

  setCategory(int categoryIndex) {
    _categoryIndex = categoryIndex;

    notifyListeners();
  }

  setSubCategory(int subCategoryIndex) {
    _subCategoryIndex = subCategoryIndex;

    notifyListeners();
  }
}
