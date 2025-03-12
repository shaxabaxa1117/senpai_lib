part of 'anime_bloc.dart';

sealed class AnimeEvent extends Equatable {
  const AnimeEvent();

  @override
  List<Object> get props => [];
}

final class LoadAnimeEvent extends AnimeEvent {
  const LoadAnimeEvent();
}

class LoadNextTopAnime extends AnimeEvent {
  const LoadNextTopAnime();
}