part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}



class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String nickname;
  SignUpEvent({required this.email,required this.password, required this.nickname});
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  SignInEvent(this.email, this.password);
}

class SignOutEvent extends AuthEvent {}

class CheckAuthEvent extends AuthEvent {}