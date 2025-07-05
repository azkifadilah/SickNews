class Article {
  final String title;
  final String description;
  final String link;
  final String imageUrl;
  final String category;

  Article({
    required this.title,
    required this.description,
    required this.link,
    required this.imageUrl,
    required this.category,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'Tanpa Judul',
      description: json['description'] ?? 'Tidak ada deskripsi.',
      link: json['link'] ?? '',
      imageUrl: json['image_url'] ?? '',
      category: (json['category'] is List && json['category'].isNotEmpty)
          ? json['category'][0]
          : 'Umum',
    );
  }

  get content => null;

  get date => null;
} 

