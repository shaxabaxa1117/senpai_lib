part of 'manga_bloc.dart';

sealed class MangaState extends Equatable {
  const MangaState();
  
  @override
  List<Object> get props => [];
}

final class MangaInitial extends MangaState {}
class MangaLoading extends MangaState {}

class MangaLoaded extends MangaState {
  final List<MangaEntity> mangas;
  const MangaLoaded(this.mangas);
  
}

class MangaError extends MangaState {
  final String message;

  const MangaError(this.message);
}

class MangaDetailLoaded extends MangaState {
  final MangaEntity manga;

 const  MangaDetailLoaded(this.manga);
}