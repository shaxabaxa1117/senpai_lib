abstract class AnimeService {
  Future<List<Map<String, dynamic>>> getCurrentlyWatchingAnime();
  Future<List<Map<String, dynamic>>> getTopAnime(int page);
}
