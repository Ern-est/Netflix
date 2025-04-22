import 'package:flutter/material.dart';
import 'package:netflix/models/movie.dart';
import 'package:netflix/models/tvshow.dart';
import 'package:netflix/screens/custom_search_delegate.dart';
import 'package:netflix/services/api_service.dart';
import 'package:netflix/screens/details_screen.dart'; // Import the details screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> _popularMovies;
  late Future<List<TVShow>> _popularTVShows;
  List<Movie> _searchResults = []; // Initialize as an empty list
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _popularMovies = ApiService().fetchPopularMovies();
    _popularTVShows = ApiService().fetchPopularTVShows();
  }

  // Function to handle search query
  void _searchMoviesAndTVShows(String query) {
    // Ensure that setState is not called during the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (query.isEmpty) {
          _searchResults = []; // Clear search results if the query is empty
        } else {
          ApiService().searchMoviesAndTVShows(query).then((results) {
            setState(() {
              _searchResults = results;
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "NETFLIX",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  searchFieldLabel: 'Search Movies and TV Shows',
                  onSearch: (query) {
                    _searchMoviesAndTVShows(query);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // Popular Movies
          FutureBuilder<List<Movie>>(
            future: _popularMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No popular movies found'));
              } else {
                final movies = snapshot.data!;
                return _buildMovieList(movies);
              }
            },
          ),
          // Popular TV Shows
          FutureBuilder<List<TVShow>>(
            future: _popularTVShows,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No popular TV shows found'));
              } else {
                final tvShows = snapshot.data!;
                return _buildTVShowList(tvShows);
              }
            },
          ),
          // Search Results (if any)
          if (_searchResults.isNotEmpty) _buildMovieList(_searchResults),
        ],
      ),
    );
  }

  Widget _buildMovieList(List<Movie> movies) {
    return Column(
      children: [
        Text(
          "Popular Movies",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              final posterUrl =
                  movie.posterUrl != null && movie.posterUrl!.isNotEmpty
                      ? 'https://image.tmdb.org/t/p/w500${movie.posterUrl}'
                      : 'https://via.placeholder.com/120x180.png?text=No+Image'; // Fallback image

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(movie: movie),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(
                        posterUrl,
                        height: 180,
                        width: 120,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                              ),
                            );
                          }
                        },
                      ),
                      Text(movie.title, style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTVShowList(List<TVShow> tvShows) {
    return Column(
      children: [
        Text(
          "Popular TV Shows",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tvShows.length,
            itemBuilder: (context, index) {
              final tvShow = tvShows[index];
              final posterUrl =
                  tvShow.posterUrl != null && tvShow.posterUrl!.isNotEmpty
                      ? 'https://image.tmdb.org/t/p/w500${tvShow.posterUrl}'
                      : 'https://via.placeholder.com/120x180.png?text=No+Image'; // Fallback image

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(tvShow: tvShow),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(
                        posterUrl,
                        height: 180,
                        width: 120,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                              ),
                            );
                          }
                        },
                      ),
                      Text(tvShow.title, style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
