import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Widgets/trending_slider.dart';
import 'package:http/http.dart' as http;
import 'Widgets/generic_slider.dart';
import 'api.dart';
import 'models/trending_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();


}



class _HomeScreenState extends State<HomeScreen> {
  late Future<List<TrendingModel>> movies;

  // @override
  //
  // void initState() {
  //
  //   movies = Api().fetchTopMovies();
  //   super.initState();
  // }


  Widget build(BuildContext context) {
    
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
                height: 40,
              ),
            ),
            Text(
              "TMDB_try",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Trending Movies",
                style: TextStyle(color: Colors.white, fontSize: height * 0.05),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            TrendingSlider(url: 'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1',),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Top Rated Movies",
                style: TextStyle(color: Colors.white, fontSize: height * 0.05),
              ),
            ),
            //https://api.themoviedb.org/3/movie/popular
            GenericSlider(url: "https://api.themoviedb.org/3/movie/popular",),

            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Up Coming Movies",
                style: TextStyle(color: Colors.white, fontSize: height * 0.05),
              ),
            ),
            GenericSlider(
              url: 'https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1',
            ),



          ],
        ),
      ),
    );
  }
}
