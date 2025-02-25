
import 'package:senpai_lib/feature/anime/domain/entity/anime.dart';

abstract class AnimeRepository {
  Future<List<AnimeEntity>> getCurrentlyWatchingAnime();
  // Future<List<AnimeEntity>> getTrendAnimeList();


}