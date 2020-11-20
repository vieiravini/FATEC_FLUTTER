import 'package:flutter/material.dart';

import 'helper/http_helper.dart';
import 'movie_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List movies;
  int itemCount;
  HttpHelper helper;

  Icon icon = Icon(Icons.search);
  Widget searchBar = Text('The MovieDB');

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  Future initialize() async {
    movies = List();
    var listMovies = await helper.getUpcoming();
    print(listMovies);
    setState(() {
      movies = listMovies;
      itemCount = movies.length;
    });
  }

  Future getUpcoming() async {
    var result = await helper.getUpcoming();
    setState(() {
      movies = result;
      itemCount = movies.length;
    });
  }

  Future searchMovies(String text) async {
    var result = await helper.findMovies(text);
    setState(() {
      movies = result;
      itemCount = movies.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: [
          IconButton(
              icon: icon,
              onPressed: () {
                setState(() {
                  if (this.icon.icon == Icons.search) {
                    this.icon = Icon(Icons.cancel);
                    this.searchBar = TextField(
                      onSubmitted: (text) {
                        searchMovies(text);
                      },
                      textInputAction: TextInputAction.search,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    );
                  } else {
                    setState(() {
                      this.icon = Icon(Icons.search);
                      this.searchBar = Text('The MovieDB');
                      getUpcoming();
                    });
                  }
                });
              })
        ],
      ),
      body: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (context, index) {
            final url =
                'https://image.tmdb.org/t/p/w500/${movies[index].posterPath}';

            return Card(
              color: Colors.white,
              elevation: 4,
              child: ListTile(
                title: Text(movies[index].title),
                subtitle: Text(
                    'Lançamento: ${movies[index].releaseDate} - Média: ${movies[index].voteAverage}'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(url),
                ),
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => MovieDetail(movies[index]));
                  Navigator.push(context, route);
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
