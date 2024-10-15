import 'package:http/http.dart';

abstract class NewsRepository {
  Future<Response> getNews(String countryCode);
}
