import 'package:http/http.dart' as http;
import 'package:tmdb/model/movie_credit.dart';
import 'package:tmdb/model/trending_movie.dart';
import 'package:tmdb/model/upcoming_movie.dart';
import '../constants.dart';

class RemoteServices {
  // trending movie
  String trendingMovieUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apikey}';
  Future<TrendingMovie?> getTrendingMovie() async {
    var client = http.Client();
    var url = Uri.parse(trendingMovieUrl);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      return trendingMovieFromJson(json);
    }
  }

  // upcomingmovie
  String upcomingMovieUrl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apikey}&language=en-US&page=1';
  Future<Upcomingmovie?> getUpcomingMovie() async {
    var client = http.Client();
    var url = Uri.parse(upcomingMovieUrl);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      return upcomingmovieFromJson(json);
    }
  }

  // credit
  Future<List<Cast>?> getMovieCredit(int movieid) async {
    String movieCreditUrl =
        'https://api.themoviedb.org/3/movie/$movieid/credits?api_key=${Constants.apikey}&language=en-US';
    var client = http.Client();
    var url = Uri.parse(movieCreditUrl);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      return movieCreditsFromJson(json).cast;
    }
  }
}
