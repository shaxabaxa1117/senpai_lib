import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:senpai_lib/core/usecase/no_params.dart';
import 'package:senpai_lib/feature/auth/domain/entity/user_entity.dart';
import 'package:senpai_lib/feature/auth/domain/params/sign_in_params.dart';
import 'package:senpai_lib/feature/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:senpai_lib/feature/auth/domain/usecase/sign_in_usecase.dart';
import 'package:senpai_lib/feature/auth/domain/usecase/sign_up_usecase.dart';
import 'package:senpai_lib/feature/auth/domain/usecase/signt_out_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUp;
  final SignInUseCase signIn;
  final SignOutUseCase signOut;
  final GetCurrentUserUseCase getCurrentUser;

  AuthBloc({required this.signUp,required this.signIn,required this.signOut,required this.getCurrentUser})
    : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signUp(
          SignUpParams(
            email: event.email,
            password: event.password,
            nickname: event.nickname,
          ),
        );
        emit(Authenticated(user));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signIn(
          SignInParams(email: event.email, password: event.password),
        );
        emit(Authenticated(user));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignOutEvent>((event, emit) async {
      await signOut(NoParams());
      emit(Unauthenticated());
    });

    on<CheckAuthEvent>((event, emit) async {
      emit(AuthLoading());
      final user = await getCurrentUser(NoParams());
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    });
  }
}
