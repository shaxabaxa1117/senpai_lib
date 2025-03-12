import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:senpai_lib/core/constants/app_consts.dart';
import 'package:senpai_lib/core/usecase/no_params.dart';
import 'package:senpai_lib/features/anime/domain/entity/anime_enity.dart';
import 'package:senpai_lib/features/anime/domain/usecases/get_currently_watching_anime_usecase.dart';
import 'package:senpai_lib/features/anime/domain/usecases/get_top_anime_usecase.dart';

part 'anime_state.dart';
part 'anime_event.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  final GetCurrentlyWatchingAnimeUsecase getCurrentlyWatchingAnime;
  final GetTopAnimeUseCase getTopAnime;

  AnimeBloc({
    required this.getCurrentlyWatchingAnime,
    required this.getTopAnime,
  }) : super(AnimeInitial()) {


    on<LoadAnimeEvent>((event, emit) async {

      emit(AnimeLoading());


      try {
        final trendAnimeList = await getCurrentlyWatchingAnime(NoParams());
        final topAnime = await getTopAnime(1);
        final hasMore = topAnime.length == AppConstants.pageSize;
        print(
          'Loaded initial data: ${trendAnimeList.length} trending, ${topAnime.length} top',
        );
        emit(
          AnimeLoadedState(
            trendAnimeList: trendAnimeList,
            topAnime: topAnime,
            currentPage: 1,
            hasMore: hasMore,
          ),
        );
      } catch (e) {
        emit(AnimeError(e.toString()));
      }
    });
    on<LoadNextTopAnime>((event, emit) async {
      
      if (state is AnimeLoadedState) {
        final currentState = state as AnimeLoadedState;
        emit(AnimeLoading());
        try {
          final nextPage = currentState.currentPage + 1;
          final newTopAnime = await getTopAnime(nextPage);
          final hasMore = newTopAnime.length == AppConstants.pageSize;
          print('Loaded page $nextPage with ${newTopAnime.length} items, hasMore: $hasMore');
          emit(AnimeLoadedState(
            trendAnimeList: currentState.trendAnimeList, //! Сохраняем trending
            topAnime: newTopAnime, //! Заменяем topAnime
            currentPage: nextPage,
            hasMore: hasMore,
          ));
        } catch (e) {
          print('Error loading next top anime: $e');
          emit(AnimeError(e.toString()));
        }
        }
      }
    );
  }
}
