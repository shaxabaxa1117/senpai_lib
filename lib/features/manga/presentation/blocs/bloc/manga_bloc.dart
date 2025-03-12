import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:senpai_lib/core/usecase/no_params.dart';

import 'package:senpai_lib/features/manga/domain/entity/manga_enity.dart';
import 'package:senpai_lib/features/manga/domain/usecases/get_top_manga_usecase.dart';

part 'manga_event.dart';
part 'manga_state.dart';

class MangaBloc extends Bloc<MangaEvent, MangaState> {
   final GetTopMangaUseCase getTopManga;
  MangaBloc({required this.getTopManga}) : super(MangaInitial()) {

      on<GetTopMangaEvent>(_onGetTopManga);

  }


  Future<void> _onGetTopManga(
    GetTopMangaEvent event,
    Emitter<MangaState> emit,
  ) async {
    emit(MangaLoading());
    try {
      final mangas = await getTopManga(NoParams());
      emit(MangaLoaded(mangas));
    } catch (e) {
      emit(MangaError('Ошибка загрузки топ манги: ${e.toString()}'));
    }
  }
  }