
import 'package:senpai_lib/features/manga/data/model/manga_model.dart';

abstract class MangaRemoteDataSource {
    Future<List<MangaModel>> getTopManga();
}