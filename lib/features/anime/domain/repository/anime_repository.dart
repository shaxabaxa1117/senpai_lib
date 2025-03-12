
import 'package:senpai_lib/features/anime/domain/entity/anime_enity.dart';

abstract class AnimeRepository {
  Future<List<AnimeEntity>> getCurrentlyWatchingAnime();
  Future<List<AnimeEntity>> getTopAnime(int page);



}