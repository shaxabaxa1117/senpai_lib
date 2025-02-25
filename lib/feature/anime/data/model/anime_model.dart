

import 'package:senpai_lib/feature/anime/domain/entity/anime.dart';
//! мы можем получать мдель побольше ноя огранилися тем что мне нужно
class AnimeModel extends AnimeEntity {
  AnimeModel({
    required int id,
    required String title,
    required String imageUrl,
    required double score,
    required String type,
    required int episodes,
  }) : super(
          id: id,
          title: title,
          imageUrl: imageUrl,
          score: score,
          type: type,
          episodes: episodes,
        );

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      id: json['mal_id'] as int,
      title: json['title'] as String,
      imageUrl: json['images']['jpg']['image_url'] as String,
      score: (json['score'] as num?)?.toDouble() ?? 0.0, // Если null, то 0.0
      type: json['type'] as String? ?? 'Unknown', // Если null, то "Unknown"
      episodes: json['episodes'] as int? ?? 0, // Если null, то 0
    );
  }


}