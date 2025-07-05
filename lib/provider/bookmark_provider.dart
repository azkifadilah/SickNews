import 'package:flutter/material.dart';
import '../model/article.dart'; // Pastikan import model Article

class BookmarkProvider with ChangeNotifier {
  final List<Article> _bookmarkedArticles = [];

  List<Article> get bookmarkedArticles => _bookmarkedArticles;

  void addBookmark(Article article) {
    if (!_bookmarkedArticles.any((item) => item.title == article.title)) {
      _bookmarkedArticles.add(article);
      notifyListeners();
    }
  }

  void removeBookmark(String title) {
    _bookmarkedArticles.removeWhere((item) => item.title == title);
    notifyListeners();
  }

  bool isBookmarked(String title) {
    return _bookmarkedArticles.any((item) => item.title == title);
  }

  void toggleBookmark(Article article) {
    final isAlreadyBookmarked = isBookmarked(article.title);
    if (isAlreadyBookmarked) {
      removeBookmark(article.title);
    } else {
      addBookmark(article);
    }
  }
}
