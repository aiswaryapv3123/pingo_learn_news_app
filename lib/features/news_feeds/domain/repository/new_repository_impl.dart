import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:pingo_learn_news/config/constants/app_strings.dart';
import 'package:pingo_learn_news/core/error/api_errors.dart';
import 'package:pingo_learn_news/core/error/api_failure.dart';
import 'package:pingo_learn_news/core/network/api_constants.dart';
import 'package:pingo_learn_news/core/network/network_services.dart';
import 'package:pingo_learn_news/features/news_feeds/data/models/news_data_model.dart';
import 'package:pingo_learn_news/features/news_feeds/domain/repository/news_repository.dart';

const apiKey = "76e74cb2e361492bb1095a303baa5a6a";

class NewsRepositoryImpl implements NewsRepository {
  final networkService = NetworkService();

  @override
  Future<Response> getNews(String countryCode) async {
    Response response = await networkService.get(
        "${ApiConstants.newsUrl}country=$countryCode&category=business&apiKey=$apiKey");
    return response;
  }
}
