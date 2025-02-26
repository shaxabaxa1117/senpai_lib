import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:senpai_lib/core/constants/app_consts.dart';
import 'package:senpai_lib/core/usecase/no_params.dart';
import 'package:senpai_lib/feature/anime/domain/entity/anime.dart';
import 'package:senpai_lib/feature/anime/domain/usecases/get_currently_watching_anime_usecase.dart';
import 'package:senpai_lib/feature/anime/domain/usecases/get_top_anime_usecase.dart';

part 'anime_state.dart';
part 'anime_event.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  final GetCurrentlyWatchingAnimeUsecase getCurrentlyWatchingAnime;
  final GetTopAnimeUseCase getTopAnime;
  bool _isFetching = false;//! контроль запросов 
  AnimeBloc({
    required this.getCurrentlyWatchingAnime,
    required this.getTopAnime,
  }) : super(AnimeInitial()) {
    on<LoadAnimeEvent>((event, emit) async {
      emit(AnimeLoading());
      try {
        final trendAnimeList = await getCurrentlyWatchingAnime(NoParams());
        final topAnime = await getTopAnime(1);
        print('Loaded initial data: ${trendAnimeList.length} trending, ${topAnime.length} top');
        emit(
          AnimeLoadedState(
            trendAnimeList: trendAnimeList,
            topAnime: topAnime,
            currentPage: 1,
            hasMore: topAnime.length == AppConstants.pageSize,
          ),
        );
      } catch (e) {
        emit(AnimeError(e.toString()));
      }
    });
    on<LoadMoreTopAnime>((event, emit) async {
      if (state is AnimeLoadedState && !_isFetching) {
        final currentState = state as AnimeLoadedState;
        if (!currentState.hasMore) {
          _isFetching = true; //! Блокируем новые запросы
          print('No more data to load');
          return;
        }
        
        print('Fetching more top anime, current page: ${currentState.currentPage}');

        try {
          //! Добавляем задержку 1 секунда перед запросом
          await Future.delayed(Duration(seconds: 2));
          final nextPage = currentState.currentPage + 1;
          final newTopAnime = await getTopAnime(nextPage);

          print('Loaded page $nextPage with ${newTopAnime.length} items');
          
          emit(AnimeLoadedState(
            trendAnimeList:currentState.trendAnimeList,
            topAnime: [...currentState.topAnime, ...newTopAnime],
            currentPage: nextPage,
            hasMore: newTopAnime.length == AppConstants.pageSize,
            
          ));
        } catch (e) {
          emit(AnimeError(e.toString()));
        }finally{
          _isFetching = false; //! Разблокируем запросы
        }
      }else{
        print('No more data to load');
      }
    });
  }
}
