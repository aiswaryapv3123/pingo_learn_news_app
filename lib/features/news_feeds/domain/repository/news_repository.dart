import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:pingo_learn_news/core/error/api_failure.dart';
import 'package:pingo_learn_news/features/news_feeds/data/models/news_data_model.dart';

abstract class NewsRepository {
  Future<Response> getNews(String countryCode);
}
