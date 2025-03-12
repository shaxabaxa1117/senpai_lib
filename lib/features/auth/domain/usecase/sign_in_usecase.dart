


import 'package:senpai_lib/core/usecase/usecase.dart';
import 'package:senpai_lib/features/auth/domain/entity/user_entity.dart';
import 'package:senpai_lib/features/auth/domain/params/sign_in_params.dart';
import 'package:senpai_lib/features/auth/domain/repository/auth_repository.dart';

class SignInUseCase implements UseCase<UserEntity, SignInParams> {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  @override
  Future<UserEntity> call(SignInParams params) async {
    return await repository.signIn(params.email, params.password);
  }
}