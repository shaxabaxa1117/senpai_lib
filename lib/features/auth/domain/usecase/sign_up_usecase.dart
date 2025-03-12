
import 'package:senpai_lib/core/usecase/usecase.dart';

import 'package:senpai_lib/features/auth/domain/entity/user_entity.dart';
import 'package:senpai_lib/features/auth/domain/repository/auth_repository.dart';

class SignUpUseCase implements UseCase<UserEntity, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<UserEntity> call(SignUpParams params) async {
    return await repository.signUp(params.email, params.password, params.nickname);
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String nickname;

  SignUpParams({
    required this.email,
    required this.password,
    required this.nickname,
  });
}