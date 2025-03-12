
import 'package:senpai_lib/core/usecase/no_params.dart';
import 'package:senpai_lib/core/usecase/usecase.dart';
import 'package:senpai_lib/features/auth/domain/entity/user_entity.dart';
import 'package:senpai_lib/features/auth/domain/repository/auth_repository.dart';

class GetCurrentUserUseCase implements UseCase<UserEntity?, NoParams> {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  @override
  Future<UserEntity?> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}