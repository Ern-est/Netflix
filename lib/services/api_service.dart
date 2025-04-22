import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix/models/movie.dart';
import 'package:netflix/models/tvshow.dart';

class ApiService {
  final String apiKey =
      '8802820491bef99be813fad350cfd663'; // Replace with your actual API key
  final String baseUrl = 'https://api.themoviedb.org/3';
  // Function to fetch search results
  Future<List<Movie>> searchMoviesAndTVShows(String query) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/search/multi?api_key=$apiKey&query=$query&language=en-US&page=1',
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data
          .where((item) => item['media_type'] == 'movie')
          .map((json) => Movie.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to search movies and TV shows');
    }
  }

  // Function to fetch popular movies
  Future<List<Movie>> fetchPopularMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=en-US&page=1'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  // Function to fetch popular TV shows
  Future<List<TVShow>> fetchPopularTVShows() async {
    final response = await http.get(
      Uri.parse('$baseUrl/tv/popular?api_key=$apiKey&language=en-US&page=1'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => TVShow.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load popular TV shows');
    }
  }

  // Function to fetch trending movies
  Future<List<Movie>> fetchTrendingMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/trending/movie/day?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load trending movies');
    }
  }
}
