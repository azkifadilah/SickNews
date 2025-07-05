import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://newsdata.io/api/1/news';
  static const String _apiKey = 'pub_00e208d575ad4e29973ab2b474466bb8';

  Future<List<dynamic>> fetchNews() async {
    final url = Uri.parse('$_baseUrl?apikey=$_apiKey&country=id&language=id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'] ?? [];
    } else {
      throw Exception('Gagal mengambil data berita');
    }
  }

  Future<List<String>> fetchCategories() async {
    final rawArticles = await fetchNews();
    final categories = <String>{};

    for (var article in rawArticles) {
      if (article['category'] != null && article['category'] is List) {
        for (var cat in article['category']) {
          categories.add(cat.toString());
        }
      }
    }

    return categories.toList();
  }
}
