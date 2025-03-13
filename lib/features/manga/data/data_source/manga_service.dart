
import 'package:senpai_lib/features/manga/data/model/manga_model.dart';

abstract class MangaService {
  Future<List<MangaModel>> getTopManga(int page);
}