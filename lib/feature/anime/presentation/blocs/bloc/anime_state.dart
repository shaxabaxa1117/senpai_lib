part of 'anime_bloc.dart';

sealed class AnimeState extends Equatable {
  const AnimeState();

  @override
  List<Object> get props => [];
}

final class AnimeInitial extends AnimeState {}

final  class AnimeLoading extends AnimeState {}

final  class AnimeLoadedState extends AnimeState {
  final List<AnimeEntity> trendAnimeList;
  final List<AnimeEntity> topAnime;
  final int currentPage;
  final bool hasMore;

  AnimeLoadedState({
    required this.trendAnimeList,
    required this.topAnime,
    required this.currentPage,
    required this.hasMore,
  });
}

final  class AnimeError extends AnimeState {
  final String message;

  AnimeError(this.message);
}
