import 'package:flutter/material.dart';
import 'package:movies/model/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;

  final imageUrl = 'https://image.tmdb.org/t/p/w500/';

  MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Image.network('$imageUrl${movie.posterPath}'),
                ),
                Text(
                  '${movie.title}',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Text(movie.overview, style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ));
  }
}
