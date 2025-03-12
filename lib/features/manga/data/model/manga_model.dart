
import 'package:senpai_lib/features/manga/domain/entity/manga_enity.dart';

class MangaModel extends MangaEntity {
  MangaModel({
    required int id,
    required String title,
    required String imageUrl,
    required String synopsis,
    required double score,
    required List<String> genres,
    required String status,
    required String type,
    required int chapters,
    required int volumes,
  }) : super(
          id: id,
          title: title,
          imageUrl: imageUrl,
          synopsis: synopsis,
          score: score,
          genres: genres,
          status: status,
          type: type,
          chapters: chapters,
          volumes: volumes,
        );

  factory MangaModel.fromJson(Map<String, dynamic> json) {
    final List<String> genresList = [];
    if (json['genres'] != null) {
      for (var genre in json['genres']) {
        genresList.add(genre['name']);
      }
    }

    return MangaModel(
      id: json['mal_id'] ?? 0,
      title: json['title'] ?? '',
      imageUrl: json['images']['jpg']['large_image_url'] ?? '',
      synopsis: json['synopsis'] ?? '',
      score: (json['score'] ?? 0.0).toDouble(),
      genres: genresList,
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      chapters: json['chapters'] ?? 0,
      volumes: json['volumes'] ?? 0,
    );
  }
}