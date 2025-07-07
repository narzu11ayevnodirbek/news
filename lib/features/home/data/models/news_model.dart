class NewsModel {
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? author;
  final DateTime? publishedAt;
  final String? sourceName;

  NewsModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.author,
    required this.publishedAt,
    required this.sourceName,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'],
      description: json['description'],
      imageUrl: json['urlToImage'],
      author: json['author'],
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'])
          : null,
      sourceName: json['source']?['name'],
    );
  }
}
