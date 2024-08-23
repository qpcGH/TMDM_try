import 'package:flutter/material.dart';
import '../models/trending_model.dart'; // Adjust the import as needed

class DetailScreen extends StatefulWidget {
  final Results movie;

  DetailScreen({required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(widget.movie.title.toString()), // Display movie title in the app bar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              Image.network(
                'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
                height: 300,
                width: double.infinity,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  widget.movie.title.toString(),
                  style: TextStyle(color: Colors.white,fontSize: 28),
                  textAlign: TextAlign.center,

                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.movie.overview.toString(),
                style: TextStyle(color: Colors.white,fontSize: 16),

              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*0.05),
              Text(
                'Released:${widget.movie.releaseDate.toString()}',
                style: TextStyle(color: Colors.grey,fontSize: 14),
                textAlign: TextAlign.left,
              ),
              // Add other movie details here
            ],
          ),
        ),
      ),
    );
  }
}
