part of 'trending_anime_bloc.dart';

sealed class TrendingAnimeEvent extends Equatable {
  const TrendingAnimeEvent();

  @override
  List<Object> get props => [];
}


final class LoadTrendingAnimeEvent extends TrendingAnimeEvent {
  const LoadTrendingAnimeEvent();
}