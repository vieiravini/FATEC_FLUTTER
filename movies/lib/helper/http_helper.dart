import 'dart:io';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../model/movie.dart';

final String key = '?api_key=d845a493a67cc545311c75e01e4cb751';
final String base = 'https://api.themoviedb.org/3/movie';
final String upcoming = '/upcoming';
final String language = '&language=pt-BR';

final String urlSearchBase =
    'https://api.themoviedb.org/3/search/movie$key&query=';

class HttpHelper {
  final String url = base + upcoming + key + language;

  Future<List> getUpcoming() async {
    var result = await http.get(url);

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = convert.jsonDecode(result.body);
      final movieMap = jsonResponse['results'];
      List movies = movieMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    }
    return null;
  }

  Future<List> findMovies(String title) async {
    final url = urlSearchBase + title;
    var result = await http.get(url);

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = convert.jsonDecode(result.body);
      final movieMap = jsonResponse['results'];
      List movies = movieMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    }
    return null;
  }
}
