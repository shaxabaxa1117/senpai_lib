import 'package:senpai_lib/features/anime/data/model/anime_model.dart';

abstract class AnimeService {
  Future<List<AnimeModel>> getCurrentlyWatchingAnime();
  Future<List<AnimeModel>> getTopAnime(int page);
}