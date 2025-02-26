class AppConstants {
  static const int pageSize = 25;

  static const String baseApiUrl = 'https://api.jikan.moe/v4';
  static const String currentlyWatchingAnimeEndpoint = '/seasons/now';
  
  static const String currentlyWatchingAnimeUrl = '$baseApiUrl$currentlyWatchingAnimeEndpoint';
  static const String contentTypeHeader = 'Content-Type';
  static const String jsonContentType = 'application/json';

}