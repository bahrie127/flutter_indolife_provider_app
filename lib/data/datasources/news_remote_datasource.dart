import 'package:flutter_news_app/core/variables.dart';
import 'package:flutter_news_app/data/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsRemoteDatasource {
  Future<NewsModel> getNews() async {
    final response = await http.get(Uri.parse(
        '${Variables.baseUrl}/v2/top-headlines?country=us&apiKey=${Variables.apiKey}'));

    if (response.statusCode == 200) {
      return NewsModel.fromJson(response.body);
    } else {
      throw Exception();
    }
  }

  Future<NewsModel> getSearchNews(String search) async {
    final response = await http.get(Uri.parse(
        '${Variables.baseUrl}/v2/top-headlines?q=$search&country=us&apiKey=${Variables.apiKey}'));

    if (response.statusCode == 200) {
      return NewsModel.fromJson(response.body);
    } else {
      throw Exception();
    }
  }
}
