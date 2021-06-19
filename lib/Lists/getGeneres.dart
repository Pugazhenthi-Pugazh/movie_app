import 'package:movie_app/API/API.dart';
import 'package:movie_app/Models/GenereResponse.dart';
import 'package:movie_app/Models/MovieResponse.dart';
import 'package:rxdart/rxdart.dart';

class GenersList {
  final API _api = API();
  final BehaviorSubject<GenereResponse> _subject =
      BehaviorSubject<GenereResponse>();

  getMovies() async {
    GenereResponse response = await _api.getGeners();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GenereResponse> get subject => _subject;
}

final genersList = GenersList();
