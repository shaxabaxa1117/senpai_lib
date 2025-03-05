import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:senpai_lib/feature/anime/data/data_sources/anime_data_service.dart';
import 'package:senpai_lib/feature/anime/data/data_sources/anime_remote_service_impl.dart';
import 'package:senpai_lib/feature/anime/data/repository/anime_repository_imp.dart';
import 'package:senpai_lib/feature/anime/domain/repository/anime_repository.dart';
import 'package:senpai_lib/feature/anime/domain/usecases/get_currently_watching_anime_usecase.dart';
import 'package:senpai_lib/feature/anime/domain/usecases/get_top_anime_usecase.dart';
import 'package:senpai_lib/feature/anime/presentation/blocs/bloc/anime_bloc.dart';
import 'package:senpai_lib/feature/auth/data/data_source/firebase_auth_data_source.dart';
import 'package:senpai_lib/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:senpai_lib/feature/auth/domain/repository/auth_repository.dart';
import 'package:senpai_lib/feature/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:senpai_lib/feature/auth/domain/usecase/sign_in_usecase.dart';
import 'package:senpai_lib/feature/auth/domain/usecase/sign_up_usecase.dart';
import 'package:senpai_lib/feature/auth/domain/usecase/signt_out_usecase.dart';
import 'package:senpai_lib/feature/auth/presentation/blocs/bloc/auth_bloc.dart';

//! все прееприлтает тут
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
            connectTimeout: Duration(seconds: 5),
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
}
