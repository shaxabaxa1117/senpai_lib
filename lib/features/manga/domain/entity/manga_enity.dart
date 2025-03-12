abstract class MangaEntity {
  final int id;
  final String title;
  final String imageUrl;
  final String synopsis;
  final double score;
  final List<String> genres;
  final String status;
  final String type;
  final int chapters;
  final int volumes;

  MangaEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.synopsis,
    required this.score,
    required this.genres,
    required this.status,
    required this.type,
    required this.chapters,
    required this.volumes,
  });
}
