part of 'manga_bloc.dart';

sealed class MangaEvent extends Equatable {
  const MangaEvent();

  @override
  List<Object> get props => [];
}

final class LoadMangaEvent extends MangaEvent {}
final class LoadNextTopManga extends MangaEvent {}