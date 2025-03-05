

import 'package:senpai_lib/core/usecase/no_params.dart';
import 'package:senpai_lib/core/usecase/usecase.dart';
import 'package:senpai_lib/feature/auth/domain/repository/auth_repository.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  @override
  Future<void> call(NoParams params) async {
    return await repository.signOut();
  }
}