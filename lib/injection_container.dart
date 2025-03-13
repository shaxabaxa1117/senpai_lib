import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:senpai_lib/features/anime/data/data_sources/anime_data_service.dart';
import 'package:senpai_lib/features/anime/data/data_sources/anime_remote_service_impl.dart';
import 'package:senpai_lib/features/anime/data/repository/anime_repository_imp.dart';
import 'package:senpai_lib/features/anime/domain/repository/anime_repository.dart';
import 'package:senpai_lib/features/anime/domain/usecases/get_currently_watching_anime_usecase.dart';
import 'package:senpai_lib/features/anime/domain/usecases/get_top_anime_usecase.dart';
import 'package:senpai_lib/features/anime/presentation/blocs/bloc/anime_bloc.dart';
import 'package:senpai_lib/features/auth/data/data_source/firebase_auth_data_source.dart';
import 'package:senpai_lib/features/auth/data/repository/auth_repository_impl.dart';
import 'package:senpai_lib/features/auth/domain/repository/auth_repository.dart';
import 'package:senpai_lib/features/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:senpai_lib/features/auth/domain/usecase/sign_in_usecase.dart';
import 'package:senpai_lib/features/auth/domain/usecase/sign_up_usecase.dart';
import 'package:senpai_lib/features/auth/domain/usecase/signt_out_usecase.dart';
import 'package:senpai_lib/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:senpai_lib/features/manga/data/data_source/manga_service.dart';
import 'package:senpai_lib/features/manga/data/data_source/manga_service_impl.dart';
import 'package:senpai_lib/features/manga/data/repository/manga_repository_impl.dart';
import 'package:senpai_lib/features/manga/domain/repository/manga_repository.dart';
import 'package:senpai_lib/features/manga/domain/usecases/get_top_manga_usecase.dart';
import 'package:senpai_lib/features/manga/presentation/blocs/bloc/manga_bloc.dart';

//! все прееприлтается тут
final sl = GetIt.instance;

Future<void> initializeDependecies() async {
  //! FireBase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  //!BLoC
  sl.registerFactory<AnimeBloc>(
    () => AnimeBloc(
      getCurrentlyWatchingAnime: sl.get<GetCurrentlyWatchingAnimeUsecase>(),
      getTopAnime: sl.get<GetTopAnimeUseCase>(),
    ),
  );

  //! Use Cases
  sl.registerLazySingleton<GetCurrentlyWatchingAnimeUsecase>(
    () => GetCurrentlyWatchingAnimeUsecase(sl.get<AnimeRepository>()),
  );
  sl.registerLazySingleton<GetTopAnimeUseCase>(
    () => GetTopAnimeUseCase(sl.get<AnimeRepository>()),
  );

  //! Repository
  sl.registerLazySingleton<AnimeRepository>(
    () => AnimeRepositoryImpl(sl.get<AnimeService>()),
  );

  //! Service
  sl.registerLazySingleton<AnimeService>(() => AnimeServiceImpl(sl.get<Dio>()));

  //! External (Dio)
  sl.registerLazySingleton<Dio>(
    () =>
        Dio()
          ..options = BaseOptions(
            connectTimeout: Duration(seconds: 10),
            receiveTimeout: Duration(seconds: 10),
          ),
  );

  sl.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSource(
      sl.get<FirebaseAuth>(),
      sl.get<FirebaseFirestore>(),
    ),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl.get<FirebaseAuthDataSource>()),
  );

  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(sl.get<AuthRepository>()),
  );

  sl.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(sl.get<AuthRepository>()),
  );

  sl.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(sl.get<AuthRepository>()),
  );

  sl.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(sl.get<AuthRepository>()),
  );

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      signUp: sl.get<SignUpUseCase>(),
      signIn: sl.get<SignInUseCase>(),
      signOut: sl.get<SignOutUseCase>(),
      getCurrentUser: sl.get<GetCurrentUserUseCase>(),
    ),
  );

  //! MANGA

  //! Data Sources
  sl.registerLazySingleton<MangaService>(
    () => MangaServiceImpl(dio: sl<Dio>(
    )),
  );

  //! Repositories
  sl.registerLazySingleton<MangaRepository>(
    () => MangaRepositoryImpl(sl<MangaService>()),
  );

  //! Use Cases
  sl.registerLazySingleton<GetTopMangaUseCase>(
    () => GetTopMangaUseCase(sl<MangaRepository>()),
  );

  //! Blocs
  sl.registerFactory<MangaBloc>(
    () => MangaBloc(getTopManga: sl<GetTopMangaUseCase>()),
  );
  
}
