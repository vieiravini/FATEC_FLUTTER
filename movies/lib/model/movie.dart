class Movie {
  int id;
  String title;
  String overview;
  String releaseDate;
  var voteAverage;
  double popularity;
  String posterPath;
  String backdropPath;

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    voteAverage = json['vote_average'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    backdropPath = json['backdrop_path'];
  }

  @override
  String toString() {
    return '''
    Movie{id=$id, title=$title, overview=$overview, releaseDate=$releaseDate, 
    voteAverage=$voteAverage, popularity=$popularity, posterPath=$posterPath, 
    backdropPath=$backdropPath}
    ''';
  }
}
