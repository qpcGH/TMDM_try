import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../detail_screen.dart';
import '../models/trending_model.dart';

class GenericSlider extends StatefulWidget {
  final String url; // Accept URL parameter

  const GenericSlider({Key? key, required this.url}) : super(key: key);

  @override
  State<GenericSlider> createState() => _GenericSliderState();
}

class _GenericSliderState extends State<GenericSlider> {
  late Future<List<Results>> _movies;

  Future<List<Results>> fetchMovies(String url) async {
    final headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMTkxNWUxZGFmNmVlYzQ4YWE4MTM2ZmVkMzA4NzAzOCIsIm5iZiI6MTcyNDQyMDEwNi43Njc2NTQsInN1YiI6IjY0YjkxYmY5MjdkYjYxMDExYzE1MDcxNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qzmtgyR8g-cY2mrLFleTaB4V89aiv6m05bRvhuiBXCY' // Replace with your API key
    };
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((item) => Results.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Results>>(
      future: fetchMovies(widget.url), // Use the existing future
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No movies available'));
        }

        final movies = snapshot.data!;

        return SizedBox(
          height: 230,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(movie: movie),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      height: 230,
                      width: 180,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: movie.posterPath != null
                                ? Image.network(
                              'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                              fit: BoxFit.cover,
                            )
                                : Container(color: Colors.grey), // Placeholder if no image
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black54,
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                movie.title ?? 'No Title', // Adjust to your model's attribute
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16, // Adjust font size if needed
                                  fontWeight: FontWeight.bold, // Adjust font weight if needed
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
