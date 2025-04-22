class TVShow {
  final String title;
  final String posterUrl;
  final String releaseDate;
  final String overview;
  final List<String> genres;
  final String videoUrl; // Add videoUrl

  // Constructor with videoUrl as a required parameter
  TVShow({
    required this.title,
    required this.posterUrl,
    required this.releaseDate,
    required this.overview,
    required this.genres,
    required this.videoUrl, // Ensure this is a required parameter
  });

  // Factory constructor to create TVShow from JSON
  factory TVShow.fromJson(Map<String, dynamic> json) {
    return TVShow(
      title: json['name'] ?? '',
      posterUrl: json['poster_path'] ?? '',
      releaseDate: json['first_air_date'] ?? 'N/A',
      overview: json['overview'] ?? 'No overview available',
      genres:
          json['genres'] != null
              ? List<String>.from(
                json['genres'].map((genre) => genre['name'] ?? 'Unknown'),
              )
              : [], // If genres is null, use an empty list
      videoUrl:
          json['video_url'] ?? '', // Ensure videoUrl is extracted from JSON
    );
  }
}
