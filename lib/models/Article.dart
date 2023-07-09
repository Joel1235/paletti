class Article {
  final String title;
  final String byline;
  final String url;
  final String imageUrl;
  final String publishedDate;
  final String summary;

  Article({
    required this.title,
    required this.byline,
    required this.url,
    required this.imageUrl,
    required this.publishedDate,
    required this.summary,
  });

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      title: map['title'],
      byline: map['byline'],
      url: map['url'],
      imageUrl: map['multimedia'].length > 1
          ? map['multimedia'][0]['url']
          : 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
      publishedDate: map['published_date'],
      summary: map['abstract'],
    );
  }
}
