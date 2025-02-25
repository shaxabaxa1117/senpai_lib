import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:senpai_lib/core/usecase/no_params.dart';
import 'package:senpai_lib/feature/anime/domain/entity/anime.dart';
import 'package:senpai_lib/feature/anime/domain/usecases/get_currently_watching_anime_usecase.dart';

part 'trending_anime_event.dart';
part 'trending_anime_state.dart';

class TrendingAnimeBloc extends Bloc<TrendingAnimeEvent, TrendingAnimeState> {
  final GetCurrentlyWatchingAnimeUsecase getCurrentlyWatchingAnime;

  TrendingAnimeBloc({required this.getCurrentlyWatchingAnime}) : super(TrendingAnimeInitial()) {
    on<LoadTrendingAnimeEvent>((event, emit) async {
      emit(TrendingAnimeLoading());
      try {
        final animeList = await getCurrentlyWatchingAnime(NoParams());
        emit(TrendingAnimeLoaded(animeList));
      } catch (e) {
        emit(TrendingAnimeError(e.toString()));
      }
    });
  }
}