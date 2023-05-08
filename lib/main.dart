// ignore_for_file: always_specify_types, prefer_final_locals, strict_raw_type

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'freezed/movie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MovieApp(),
    );
  }
}

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {

  final List <Movie> _movie =<Movie>[];


  @override
  void initState() {
    _getMovie();
    super.initState();
  }

  Future<void> _getMovie() async {
    Uri uri = Uri(
      scheme: 'https',
      host: 'yts.mx',
      pathSegments: <String>['api', 'v2', 'list_movies.json'],
    );
    final Response response = await get(uri);
    final Map<String, dynamic>body = jsonDecode(response.body) as Map<String, dynamic>;
    Map<String, dynamic>data = body['data'] as Map<String, dynamic>;
    List<dynamic>movies = data['movies'] as List<dynamic>;

    for (int i = 0; i < movies.length; i++) {
      final Map<String, dynamic> movie = movies[i] as Map<String, dynamic>;

      _movie.add(Movie.fromJson(movie));
    }

    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        itemCount: _movie.length,
        itemBuilder: (BuildContext context, int index) {
          final Movie movie = _movie[index];
          return GridTile(footer: ListTile(
            title: Text(movie.title),
          ),
            child: Image.network(movie.image),);},
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );
  }

}
