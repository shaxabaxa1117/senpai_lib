import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:senpai_lib/core/constants/app_consts.dart';
import 'package:senpai_lib/core/usecase/no_params.dart';

import 'package:senpai_lib/features/manga/domain/entity/manga_enity.dart';
import 'package:senpai_lib/features/manga/domain/usecases/get_top_manga_usecase.dart';

part 'manga_event.dart';
part 'manga_state.dart';

class MangaBloc extends Bloc<MangaEvent, MangaState> {
  final GetTopMangaUseCase getTopManga;

  MangaBloc({required this.getTopManga}) : super(MangaInitial()) {
    on<LoadMangaEvent>(_onLoadManga);
    on<LoadNextTopManga>(_onLoadNextTopManga);
  }

  Future<void> _onLoadManga(
    LoadMangaEvent event,
    Emitter<MangaState> emit,
  ) async {
    emit(MangaLoading(isInitialLoad: true));
    try {
      final topManga = await getTopManga(1); // Первая страница
      final hasMore = topManga.length == AppConstants.pageSize;
      print('Loaded initial page: ${topManga.length} manga');
      emit(MangaLoadedState(
        topManga: topManga,
        currentPage: 1,
        hasMore: hasMore,
      ));
    } catch (e) {
      print('Error loading manga: $e');
      emit(MangaError(e.toString()));
    }
  }

  Future<void> _onLoadNextTopManga(
    LoadNextTopManga event,
    Emitter<MangaState> emit,
  ) async {
    if (state is MangaLoadedState) {
      final currentState = state as MangaLoadedState;
      if (!currentState.hasMore) return;

      emit(MangaLoading(isInitialLoad: false));
      try {
        final nextPage = currentState.currentPage + 1;
        final newTopManga = await getTopManga(nextPage); // Только новые 25 манг
        final hasMore = newTopManga.length == AppConstants.pageSize;
        print('Loaded page $nextPage with ${newTopManga.length} manga');
        emit(MangaLoadedState(
          topManga: newTopManga, // Заменяем список, а не добавляем
          currentPage: nextPage,
          hasMore: hasMore,
        ));
      } catch (e) {
        print('Error loading next manga: $e');
        emit(MangaError(e.toString()));
      }
    }
  }
}