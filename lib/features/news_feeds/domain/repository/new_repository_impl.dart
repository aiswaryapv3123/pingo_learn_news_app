
import 'package:http/http.dart';
import 'package:pingo_learn_news/core/network/api_constants.dart';
import 'package:pingo_learn_news/core/network/network_services.dart';
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
