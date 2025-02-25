
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:senpai_lib/feature/anime/data/data_sources/anime_data_service.dart';
import 'package:senpai_lib/feature/anime/data/data_sources/anime_remote_service_impl.dart';
import 'package:senpai_lib/feature/anime/data/repository/anime_repository_imp.dart';
import 'package:senpai_lib/feature/anime/domain/repository/anime_repository.dart';
import 'package:senpai_lib/feature/anime/domain/usecases/get_currently_watching_anime_usecase.dart';
import 'package:senpai_lib/feature/anime/presentation/blocs/bloc/trending_anime_bloc.dart';

//! все прееприлтает тут
final sl = GetIt.instance;

Future<void>  initializeDependecies() async{
  //BLoC
  sl.registerFactory<TrendingAnimeBloc>(
    () => TrendingAnimeBloc(
      getCurrentlyWatchingAnime: sl.get<GetCurrentlyWatchingAnimeUsecase>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<GetCurrentlyWatchingAnimeUsecase>(
    () => GetCurrentlyWatchingAnimeUsecase(
      sl.get<AnimeRepository>(),
    ),
  );

  // Repository
  sl.registerLazySingleton<AnimeRepository>(
    () => AnimeRepositoryImpl(
      sl.get<AnimeService>(),
    ),
  );

  // Service
  sl.registerLazySingleton<AnimeService>(
    () => AnimeServiceImpl(
      sl.get<Dio>(),
    ),
  );

  // External (Dio)
  sl.registerLazySingleton<Dio>(
    () => Dio()
      ..options = BaseOptions(
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 10),
      ),
  );
}


