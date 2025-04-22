class Movie {
  final String title;
  final String posterUrl;
  final String releaseDate;
  final String overview;
  final List<String> genres;
  final String videoUrl; // Add this field

  Movie({
    required this.title,
    required this.posterUrl,
    required this.releaseDate,
    required this.overview,
    required this.genres,
    required this.videoUrl, // Include it in the constructor
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? '',
      posterUrl: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? 'N/A',
      overview: json['overview'] ?? 'No overview available',
      genres:
          json['genres'] != null
              ? List<String>.from(
                json['genres'].map((genre) => genre['name'] ?? 'Unknown'),
              )
              : [],

      // If genres is null, use an empty list
      videoUrl:
          json['video_url'] ?? '', // Ensure videoUrl is extracted from JSON
    );
  }
}
