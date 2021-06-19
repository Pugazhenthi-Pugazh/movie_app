import 'package:flutter/cupertino.dart';
import 'package:movie_app/API/API.dart';
import 'package:movie_app/Models/MovieResponse.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListByGeners {
  final API _api = API();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMoviesByGeners(int id) async {
    MovieResponse response = await _api.getMoviesByGenere(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value == null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final moviesByGenersList = MoviesListByGeners();
