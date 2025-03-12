import 'package:senpai_lib/features/manga/data/data_source/manga_remote_data_source.dart';
import 'package:senpai_lib/features/manga/domain/entity/manga_enity.dart';
import 'package:senpai_lib/features/manga/domain/repository/manga_repository.dart';

class MangaRepositoryImpl implements MangaRepository {
    final MangaRemoteDataSource remoteDataSource;


  MangaRepositoryImpl(this.remoteDataSource);


  @override
  Future<List<MangaEntity>> getTopManga() async{

   return await remoteDataSource.getTopManga();
   
  }


}