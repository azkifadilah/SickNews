import 'package:flutter/material.dart';

class BookmarkProvider with ChangeNotifier {
  final List<Map<String, String>> _bookmarks = [];

  List<Map<String, String>> get bookmarks => _bookmarks;

  void addBookmark(Map<String, String> article) {
    if (!_bookmarks.any((item) => item['title'] == article['title'])) {
      _bookmarks.add(article);
      notifyListeners();
    }
  }

  void removeBookmark(String title) {
    _bookmarks.removeWhere((item) => item['title'] == title);
    notifyListeners();
  }

  bool isBookmarked(String title) {
    return _bookmarks.any((item) => item['title'] == title);
  }
}
