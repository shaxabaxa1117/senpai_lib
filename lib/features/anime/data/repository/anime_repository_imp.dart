

import 'package:senpai_lib/core/error/exceptions.dart';
import 'package:senpai_lib/features/anime/data/data_sources/anime_data_service.dart';
import 'package:senpai_lib/features/anime/domain/entity/anime_enity.dart';
import 'package:senpai_lib/features/anime/domain/repository/anime_repository.dart';

class AnimeRepositoryImpl implements AnimeRepository {//! тут свзывается domain и data
  final AnimeService _animeService;

  AnimeRepositoryImpl(this._animeService);

  @override
  Future<List<AnimeEntity>> getCurrentlyWatchingAnime() async {
    try {
      final animeModels = await _animeService.getCurrentlyWatchingAnime();
      return animeModels; // AnimeModel extends AnimeEntity, можно вернуть напрямую
    } catch (e) {
      throw ServerException('Failed to fetch currently watching anime: $e');
    }
  }

  @override
  Future<List<AnimeEntity>> getTopAnime(int page) async {
    try {
      final animeModels = await _animeService.getTopAnime(page);
      return animeModels; // Аналогично
    } catch (e) {
      throw ServerException('Error: $e');
    }
  }
}