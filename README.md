🎬 Netflix Clone App (Flutter)
A sleek and functional Netflix clone app built with Flutter, powered by TMDb API, allowing users to browse, search, and view popular movies and TV shows — with a modern UI inspired by the real Netflix experience.

📱 Features
🔥 Home Screen

Showcases popular movies and TV shows

Scrollable horizontal carousels

Dynamic data loading from the TMDb API

🔍 Search Functionality

Custom search using SearchDelegate

Real-time results for both movies and TV shows

Loading indicators, fallback images, and error handling

📄 Details Page

Tapping a movie or TV show opens a detail screen

Displays poster, title, description, and more

📦 Clean Architecture

models/: Dart models for Movie and TVShow

services/: API service to fetch data from TMDb

screens/: UI components (home, details, search)

🛠️ Tech Stack
Flutter (latest stable version)

Dart

TMDb API – for fetching movies and TV show data

REST API with http package

🔧 Setup & Run Locally
Clone this repo
git clone https://github.com/Ern-est/Netflix.git
cd Netflix
Install dependencies

flutter pub get
Add your TMDb API Key
Create a file or directly add the API key in api_service.dart like:

final String apiKey = 'YOUR_TMDB_API_KEY';
Run the app

flutter run
📁 Folder Structure
css
Copy
Edit
lib/
│
├── models/
│   ├── movie.dart
│   └── tvshow.dart
│
├── services/
│   └── api_service.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── details_screen.dart
│   └── custom_search_delegate.dart
│
└── main.dart
🌐 API Credits
This project uses the TMDb API but is not endorsed or certified by TMDb.

📣 Author
Ernest Cheruiyot
💻 GitHub: @Ern-est
🌐 Portfolio: meek-mochi-7a349e.netlify.app
📧 Email: anest.developer@gmail.com

⭐️ Show Some Love
If you like this project, give it a ⭐️ on GitHub and share it with others!

![netflix3](https://github.com/user-attachments/assets/a7455832-5166-415d-ba23-ecd1f1a330b3)

![netflix2](https://github.com/user-attachments/assets/a78a56a6-4d88-4932-bf0f-20a9c52fc000)

![netflix4](https://github.com/user-attachments/assets/27030e85-aea4-4153-bd2d-9e3d36cf09e3)
