import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:pingo_learn_news/config/constants/app_strings.dart';
import 'package:pingo_learn_news/core/error/api_errors.dart';
import 'package:pingo_learn_news/core/error/api_failure.dart';
import 'package:pingo_learn_news/features/news_feeds/data/models/news_data_model.dart';
import 'package:pingo_learn_news/features/news_feeds/domain/repository/news_repository.dart';

class NewsProvider extends ChangeNotifier {
  final NewsRepository newsRepository;

  bool newsLoading = false;
  String? errorMessage;
  NewsDataModel? newsDataModel;

  NewsProvider({required this.newsRepository});

  getNewsFeed(String countryCode) async {
    newsLoading = true;
    Response response = await newsRepository.getNews(countryCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      newsDataModel = NewsDataModel.fromJson(jsonDecode(response.body));
    } else {
      var responseData = jsonDecode(response.body);
      errorMessage = responseData['message'] ?? AppStrings.failedToConnect;
      updateNewsLoading(false);
    }
    newsLoading = false;
    notifyListeners();
  }

  updateNewsLoading(bool value) {
    newsLoading = value;
    notifyListeners();
  }
}
