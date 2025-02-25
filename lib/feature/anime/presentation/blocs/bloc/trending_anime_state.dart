part of 'trending_anime_bloc.dart';

sealed class TrendingAnimeState extends Equatable {
  const TrendingAnimeState();

  @override
  List<Object> get props => [];
}

final class TrendingAnimeInitial extends TrendingAnimeState {}

class TrendingAnimeLoading extends TrendingAnimeState {}

class TrendingAnimeLoaded extends TrendingAnimeState {
  final List<AnimeEntity> animeList;

  TrendingAnimeLoaded(this.animeList);
}

class TrendingAnimeError extends TrendingAnimeState {
  final String message;

  TrendingAnimeError(this.message);
}
