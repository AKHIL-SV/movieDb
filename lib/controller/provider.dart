import 'package:flutter/material.dart';
import 'package:tmdb/model/movie_credit.dart';
import 'package:tmdb/model/trending_movie.dart';
import 'package:tmdb/model/upcoming_movie.dart';
import 'package:tmdb/services/apifetch.dart';

class MovieProvider extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  TrendingMovie? _trendingMovie;
  TrendingMovie? get trendingmovie => _trendingMovie;
  Upcomingmovie? _upcomingmovie;
  Upcomingmovie? get upcomingmovie => _upcomingmovie;

  getMoviedata() async {
    _trendingMovie = await RemoteServices().getTrendingMovie();
    _upcomingmovie = await RemoteServices().getUpcomingMovie();

    notifyListeners();

    if (_trendingMovie != null && _upcomingmovie != null) {
      _isloading = true;
      notifyListeners();
    }
  }

  bool _isloadingCast = false;
  bool get isloadingCast => _isloadingCast;
  List<Cast>? _movieCredit;
  List<Cast>? get movieCredit => _movieCredit;
  getMovieCreditdata(int movieid) async {
    _movieCredit = await RemoteServices().getMovieCredit(movieid);
    notifyListeners();
    if (_trendingMovie != null) {
      _isloadingCast = true;
      notifyListeners();
    }
  }
}
