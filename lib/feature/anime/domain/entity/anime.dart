import 'package:equatable/equatable.dart';

class AnimeEntity extends Equatable {
  final int id; // mal_id из Jikan API
  final String title; // Название аниме
  final String imageUrl; // URL постера
  final double score; // Рейтинг
  final String type; // Тип (TV, OVA, Movie)
  final int episodes; // Количество эпизодов
  final String synopsis; // Полное описание из Jikan API
  final List<String> genres; // Жанры
  final String status; // Статус
  final DateTime? airedFrom; // Дата начала трансляции
  final int popularity; // Популярность

  AnimeEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.score,
    required this.type,
    required this.episodes,
    required this.synopsis,
    required this.genres,
    required this.status,
    this.airedFrom,
    required this.popularity,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    imageUrl,
    score,
    type,
    episodes,
    synopsis,
    genres,
    status,
    airedFrom,
    popularity,
  ];
}
