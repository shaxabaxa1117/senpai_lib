part of 'manga_bloc.dart';

sealed class MangaState extends Equatable {
  const MangaState();

  @override
  List<Object> get props => [];
}

class MangaInitial extends MangaState {}

class MangaLoading extends MangaState {
  final bool isInitialLoad;

  MangaLoading({required this.isInitialLoad});
}

class MangaLoadedState extends MangaState {
  final List<MangaEntity> topManga;
  final int currentPage;
  final bool hasMore;

  MangaLoadedState({
    required this.topManga,
    required this.currentPage,
    required this.hasMore,
  });
}

class MangaError extends MangaState {
  final String message;

  MangaError(this.message);
}
