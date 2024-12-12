import 'package:flutter/material.dart';

import 'package:flutter_news_app/data/datasources/news_remote_datasource.dart';
import 'package:flutter_news_app/data/models/news_model.dart';

class NewsProvider extends ChangeNotifier {
  List<Article> _articles = [];

  List<Article> get articles => _articles;

  NewsState state = NewsState(
    status: StateEnum.loading,
    data: [],
  );

  void getNews() async {
    await Future.delayed(const Duration(seconds: 3));
    final response = await NewsRemoteDatasource().getNews();
    _articles = response.articles ?? [];
    state = state.copyWith(status: StateEnum.success, data: _articles);
    notifyListeners();
  }

  void getSearchNews(String search) async {
    state = state.copyWith(status: StateEnum.loading);
    // notifyListeners();
    final response = await NewsRemoteDatasource().getSearchNews(search);
    _articles = response.articles ?? [];
    state = state.copyWith(status: StateEnum.success, data: _articles);
    // notifyListeners();
  }
}

enum StateEnum { loading, success, error }

class NewsState {
  final StateEnum status;
  final List<Article> data;

  NewsState({required this.status, required this.data});

  NewsState copyWith({
    StateEnum? status,
    List<Article>? data,
  }) {
    return NewsState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
}
