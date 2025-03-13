import 'package:senpai_lib/core/error/exceptions.dart';
import 'package:senpai_lib/features/manga/data/data_source/manga_service.dart';
import 'package:senpai_lib/features/manga/domain/entity/manga_enity.dart';
import 'package:senpai_lib/features/manga/domain/repository/manga_repository.dart';

class MangaRepositoryImpl implements MangaRepository {
  final MangaService remoteDataSource;

  MangaRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MangaEntity>> getTopManga(int page) async {
    try {
      return await remoteDataSource.getTopManga(page);
      
    } catch (e) {
      throw ServerException('Error: $e');
    }
  }
}