import 'package:equatable/equatable.dart';

 class AnimeEntity extends Equatable {
  final int id;
  final String title; 
  final String imageUrl; 
  final double score; 
  final String type; 
  final int episodes; 
  final String synopsis;
  final List<String> genres; 
  final String status; 
  final DateTime? airedFrom; 
  final int popularity; 

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
