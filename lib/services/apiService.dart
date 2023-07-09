import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Article.dart';

class ApiService {
  final String _baseUrl = 'api.nytimes.com';
  static const String API_KEY = 'Dy6mx2J6hRuJg8dbQczWsmfg8xn4fQkO';

  Future<List<Article>> fetchArticlesBySection(String section) async {
    Map<String, String> parameters = {
      'api-key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/svc/topstories/v2/$section.json',
      parameters,
    );
    try {
      var response = await http.get(uri);
      Map<String, dynamic> data = json.decode(response.body);
      List<Article> articles = [];
      if (data['results'] != null && data['results'].isNotEmpty) {
        data['results'].forEach(
          (articleMap) => articles.add(Article.fromMap(articleMap)),
        );
      }
      return articles;
    } catch (err) {
      throw err.toString();
    }
  }
}
