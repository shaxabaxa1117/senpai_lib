

import 'package:senpai_lib/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {

  Future<UserEntity> signUp(String email, String password, String nickname);
  Future<UserEntity> signIn(String email, String password);
  Future<void> signOut();
  Future<UserEntity?> getCurrentUser();
}

