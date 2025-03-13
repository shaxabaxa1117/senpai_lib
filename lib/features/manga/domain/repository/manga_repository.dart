import 'package:senpai_lib/features/manga/domain/entity/manga_enity.dart';

abstract class MangaRepository {
 Future<List<MangaEntity>> getTopManga(int page);

}