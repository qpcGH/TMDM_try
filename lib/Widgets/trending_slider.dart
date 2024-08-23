import 'dart:convert';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/detail_screen.dart';
import '../models/trending_model.dart';

class TrendingSlider extends StatefulWidget {
  final String url; // Add a URL parameter

  const TrendingSlider({Key? key, required this.url}) : super(key: key);

  @override
  State<TrendingSlider> createState() => _TrendingSliderState();
}

class _TrendingSliderState extends State<TrendingSlider> {
  late Future<List<Results>> _trendingMovies;

  @override
  void initState() {
    super.initState();
    _trendingMovies = fetchTrendingMovies(widget.url); // Pass the URL to the method
  }

  Future<List<Results>> fetchTrendingMovies(String url) async {
    final headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMTkxNWUxZGFmNmVlYzQ4YWE4MTM2ZmVkMzA4NzAzOCIsIm5iZiI6MTcyNDQyMDEwNi43Njc2NTQsInN1YiI6IjY0YjkxYmY5MjdkYjYxMDExYzE1MDcxNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qzmtgyR8g-cY2mrLFleTaB4V89aiv6m05bRvhuiBXCY' // Replace with your API key
    };
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      List<Results> trendingMovies = (data['results'] as List)
          .map((item) => Results.fromJson(item))
          .toList();
      return trendingMovies;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Results>>(
      future: _trendingMovies, // Use the existing future
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        }

        List<Results> trendingMovies = snapshot.data!;

        return CarouselSlider.builder(
          itemCount: trendingMovies.length,
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            autoPlay: true,
            height: 400, // Adjust height as needed
            enableInfiniteScroll: true,
            viewportFraction: 0.8, // Adjust this fraction to control item width
            enlargeCenterPage: true,
            pageSnapping: true,
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
          ),
          itemBuilder: (BuildContext context, int index, int realIndex) {
            final movie = trendingMovies[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(movie: movie),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      ),
                      SizedBox(height: 10), // Space between image and title
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
