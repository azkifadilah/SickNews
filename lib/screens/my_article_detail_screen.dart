import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/my_article_provider.dart';
import 'article_form_screen.dart';

class MyArticleDetailScreen extends StatelessWidget {
  final Map<String, String> article;
  final int index;

  const MyArticleDetailScreen({super.key, required this.article, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Artikel Saya'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleFormScreen(
                    article: article,
                    index: index,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Provider.of<MyArticleProvider>(context, listen: false).deleteArticle(index);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Artikel berhasil dihapus!')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article['title'] ?? '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(article['category'] ?? '-'),
              backgroundColor: Colors.blueGrey[100],
            ),
            const SizedBox(height: 24),
            Text(
              article['content'] ?? '',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}