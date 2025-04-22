import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  final String searchFieldLabel;
  final Function(String) onSearch;

  CustomSearchDelegate({
    required this.searchFieldLabel,
    required this.onSearch,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          onSearch(query); // Call the search handler whenever query is cleared
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query); // Perform the search when results are shown

    // Return a simple loading indicator while results are being fetched
    return FutureBuilder(
      future: onSearch(query), // Assuming onSearch returns a future
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return Center(child: Text('No results found'));
        } else {
          // Safe cast to List<Movie> or List<TVShow>
          List movies = snapshot.data as List;

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                title: Text(movie.title),
                onTap: () {
                  // Handle item tap to navigate to the detail screen, if applicable
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onSearch(
      query,
    ); // Trigger search while typing to show suggestions in real-time

    return FutureBuilder(
      future: onSearch(query), // Assuming onSearch returns a future
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return Center(child: Text('No suggestions found'));
        } else {
          // Safe cast to List<Movie> or List<TVShow>
          List suggestions = snapshot.data as List;

          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = suggestions[index];
              return ListTile(
                title: Text(suggestion.title),
                onTap: () {
                  query = suggestion.title;
                  showResults(
                    context,
                  ); // Show results for the selected suggestion
                },
              );
            },
          );
        }
      },
    );
  }
}
