
import 'package:equatable/equatable.dart';

class AnimeEntity extends Equatable{

  final int id; //! mal_id из Jikan API
  final String title; //! Название аниме
  final String imageUrl; //! URL постера
  final double score; //! Рейтинг
  final String type; //! Тип (TV, OVA, Movie)
  final int episodes; //! Количество эпизодов

  AnimeEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.score,
    required this.type,
    required this.episodes,
  });
  
  @override

  List<Object?> get props => [
    id,
    title,
    imageUrl,
    score,
    type,
    episodes,
  ];


}