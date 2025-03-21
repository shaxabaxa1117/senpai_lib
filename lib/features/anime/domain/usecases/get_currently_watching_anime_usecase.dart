
import 'package:senpai_lib/core/usecase/no_params.dart';
import 'package:senpai_lib/core/usecase/usecase.dart';
import 'package:senpai_lib/features/anime/domain/entity/anime_enity.dart';
import 'package:senpai_lib/features/anime/domain/repository/anime_repository.dart';

class GetCurrentlyWatchingAnimeUsecase implements UseCase<List<AnimeEntity>, NoParams>{

  final AnimeRepository _animeRepository;
  GetCurrentlyWatchingAnimeUsecase(this._animeRepository);
  
  @override
  Future<List<AnimeEntity>> call(NoParams params) async{
    
    return await _animeRepository.getCurrentlyWatchingAnime();
  }




}