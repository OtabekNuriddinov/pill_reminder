
import 'dart:convert';

import 'package:medicine_reminder/core/models/news_article.dart';
import 'package:http/http.dart' as http;

class NewsService{
  final String apiKey;

  NewsService({required this.apiKey});

  Future<List<NewsArticle>> fetchHealthNews()async{
    final url = Uri.parse('https://newsapi.org/v2/top-headlines?category=health&country=us&apiKey=$apiKey');

    try{
    print("Requesting URL: $url");
    final response = await http.get(url);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);

      if(data['articles'] == null || (data['articles'] as List).isEmpty){
        print('No articles found');
        return [];
      }
      List articles = data['articles'];
      return articles.map((json)=>NewsArticle.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load news');
    }
  } catch(e){
      print("Fetch news error: $e");
      rethrow;
    }
}
}