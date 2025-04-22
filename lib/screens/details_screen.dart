import 'package:flutter/material.dart';
import 'package:netflix/models/movie.dart';
import 'package:netflix/models/tvshow.dart';
import 'package:netflix/screens/video_player_screen.dart';

class DetailsScreen extends StatelessWidget {
  final Movie? movie;
  final TVShow? tvShow;

  // Constructor to accept a Movie or TVShow object
  DetailsScreen({this.movie, this.tvShow});

  @override
  Widget build(BuildContext context) {
    final isMovie = movie != null;

    return Scaffold(
      appBar: AppBar(title: Text(isMovie ? movie!.title : tvShow!.title)),
      body: ListView(
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500${isMovie ? movie!.posterUrl : tvShow!.posterUrl}',
            fit: BoxFit.cover,
            height: 250,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isMovie ? movie!.title : tvShow!.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Release: ${isMovie ? movie!.releaseDate : tvShow!.releaseDate}',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  'Genres: ${isMovie ? movie!.genres.join(", ") : tvShow!.genres.join(", ")}',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 16),
                Text(
                  'Overview',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  isMovie ? movie!.overview : tvShow!.overview,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the video player screen and pass the video URL
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => VideoPlayerScreen(
                              videoUrl:
                                  isMovie ? movie!.videoUrl : tvShow!.videoUrl,
                            ),
                      ),
                    );
                  },
                  child: Text('Play'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
