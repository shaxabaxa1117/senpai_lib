

import 'package:senpai_lib/features/anime/domain/entity/anime_enity.dart';
//! мы можем получать мдель побольше ноя огранилися тем что мне нужно


class AnimeModel extends AnimeEntity {
  AnimeModel({
    required int id,
    required String title,
    required String imageUrl,
    required double score,
    required String type,
    required int episodes,
    required String synopsis,
    required List<String> genres,
    required String status,
    DateTime? airedFrom,
    required int popularity,
  }) : super(
          id: id,
          title: title,
          imageUrl: imageUrl,
          score: score,
          type: type,
          episodes: episodes,
          synopsis: synopsis,
          genres: genres,
          status: status,
          airedFrom: airedFrom,
          popularity: popularity,
        );

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      id: json['mal_id'] as int,
      title: json['title'] as String,
      imageUrl: json['images']['jpg']['image_url'] as String,
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      type: json['type'] as String? ?? 'Unknown',
      episodes: json['episodes'] as int? ?? 0,
      synopsis: json['synopsis'] as String? ?? 'No synopsis available',
      genres: (json['genres'] as List<dynamic>?)
              ?.map((genre) => genre['name'] as String)
              .toList() ??
          [],
      status: json['status'] as String? ?? 'Unknown',
      airedFrom: json['aired'] != null && json['aired']['from'] != null
          ? DateTime.parse(json['aired']['from'] as String)
          : null,
      popularity: json['popularity'] as int? ?? 0,
    );
  }
}