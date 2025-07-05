// File: lib/provider/my_article_provider.dart
import 'package:flutter/material.dart';

class MyArticleProvider with ChangeNotifier {
  final List<Map<String, String>> _myArticles = [];

  List<Map<String, String>> get myArticles => _myArticles;

  void addArticle(Map<String, String> article) {
    _myArticles.add(article);
    notifyListeners();
  }

  void editArticle(int index, Map<String, String> newArticle) {
    _myArticles[index] = newArticle;
    notifyListeners();
  }

  void deleteArticle(int index) {
    _myArticles.removeAt(index);
    notifyListeners();
  }
}
