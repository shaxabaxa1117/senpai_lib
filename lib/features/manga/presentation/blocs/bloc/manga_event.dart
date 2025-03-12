part of 'manga_bloc.dart';

sealed class MangaEvent extends Equatable {
  const MangaEvent();

  @override
  List<Object> get props => [];
}

class GetTopMangaEvent extends MangaEvent {}