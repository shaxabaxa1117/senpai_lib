

import 'package:senpai_lib/core/usecase/usecase.dart';
import 'package:senpai_lib/features/anime/domain/entity/anime_enity.dart';
import 'package:senpai_lib/features/anime/domain/repository/anime_repository.dart';

class GetTopAnimeUseCase implements UseCase<List<AnimeEntity>, int> {
  final AnimeRepository repository;

  GetTopAnimeUseCase(this.repository);

  @override
  Future<List<AnimeEntity>> call(int page) async {
    return await repository.getTopAnime(page);
  }
}