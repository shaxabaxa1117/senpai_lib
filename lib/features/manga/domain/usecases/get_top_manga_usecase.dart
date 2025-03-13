
import 'package:senpai_lib/core/usecase/usecase.dart';
import 'package:senpai_lib/features/manga/domain/entity/manga_enity.dart';
import 'package:senpai_lib/features/manga/domain/repository/manga_repository.dart';

class GetTopMangaUseCase implements UseCase<List<MangaEntity>, int> {
  final MangaRepository repository;

  GetTopMangaUseCase(this.repository);

  @override
  Future<List<MangaEntity>> call(int page) async {
    return await repository.getTopManga(page);
  }
}