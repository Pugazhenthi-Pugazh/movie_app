import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/Lists/getMoviesbyGeners.dart';
import 'package:movie_app/Models/Movie.dart';
import 'package:movie_app/Models/MovieResponse.dart';
import 'package:movie_app/Theme/theme.dart' as Style;

class GenerMovies extends StatefulWidget {
  final int generid;

  GenerMovies({Key? key, required this.generid}) : super(key: key);

  @override
  _GenerMoviesState createState() => _GenerMoviesState(generid);
}

class _GenerMoviesState extends State<GenerMovies> {
  final int generid;
  _GenerMoviesState(this.generid);

  @override
  void initState() {
    super.initState();
    moviesByGenersList.getMoviesByGeners(generid);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: moviesByGenersList.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null && snapshot.data!.error.length > 0) {
            return _buildErrorWidget(snapshot.data!.error);
          }
          return _buildMoviesByGeners(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.data!.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: "),
      ],
    ));
  }

  Widget _buildMoviesByGeners(MovieResponse? data) {
    List<Movie> movies = data!.movies;
    if (movies.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No  Movies",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 270,
        padding: EdgeInsets.only(
          left: 10.0,
        ),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                  right: 10.0,
                ),
                child: Column(children: [
                  movies[index].poster == null
                      ? Container(
                          height: 180,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Style.Colors.secondColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                            shape: BoxShape.rectangle,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                EvaIcons.filmOutline,
                                color: Colors.white,
                                size: 50.0,
                              )
                            ],
                          ),
                        )
                      : Container(
                          width: 120.0,
                          height: 180.0,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w200/" +
                                        movies[index].poster),
                                fit: BoxFit.cover),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 100.0,
                    child: Text(
                      movies[index].title,
                      maxLines: 2,
                      style: TextStyle(
                          height: 1.4,
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text(
                        movies[index].rating.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      RatingBar.builder(
                        itemSize: 8.0,
                        initialRating: movies[index].rating / 2,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                          EvaIcons.star,
                          color: Style.Colors.secondColor,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      )
                    ],
                  )
                ]),
              );
            }),
      );
  }
}
