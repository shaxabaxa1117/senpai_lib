

import 'package:senpai_lib/core/error/exceptions.dart';
import 'package:senpai_lib/feature/anime/data/data_sources/anime_data_service.dart';
import 'package:senpai_lib/feature/anime/data/model/anime_model.dart';
import 'package:senpai_lib/feature/anime/domain/entity/anime_enity.dart';
import 'package:senpai_lib/feature/anime/domain/repository/anime_repository.dart';

class AnimeRepositoryImpl implements AnimeRepository{ //! тут свзывается domain и data

  final AnimeService _animeService;
  AnimeRepositoryImpl(this._animeService); //вводим 



  @override
  Future<List<AnimeEntity>> getCurrentlyWatchingAnime() async{

    try {
      final remoteCurrentlyWatchingAnime = await _animeService.getCurrentlyWatchingAnime();
      return remoteCurrentlyWatchingAnime.map((json) => AnimeModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch currently watching anime: $e');
    }

    
  }
  
  
@override
  Future<List<AnimeEntity>> getTopAnime(int page) async {
    try {
      final remoteAnime = await _animeService.getTopAnime(page);
      return remoteAnime.map((json) => AnimeModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException('Error: $e');
    }
  }



}