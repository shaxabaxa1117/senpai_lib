import 'package:senpai_lib/core/usecase/no_params.dart';
import 'package:senpai_lib/core/usecase/usecase.dart';
import 'package:senpai_lib/features/manga/domain/entity/manga_enity.dart';
import 'package:senpai_lib/features/manga/domain/repository/manga_repository.dart';

class GetTopMangaUseCase extends UseCase<List<MangaEntity>, NoParams> {
  final MangaRepository _repository;
  GetTopMangaUseCase(this._repository);

  @override
  Future<List<MangaEntity>> call(NoParams params) async {
    return await _repository.getTopManga();
  }
}