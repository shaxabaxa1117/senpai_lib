

import 'package:senpai_lib/feature/auth/data/data_source/firebase_auth_data_source.dart';
import 'package:senpai_lib/feature/auth/domain/entity/user_entity.dart';
import 'package:senpai_lib/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity> signUp(String email, String password, String nickname) async {
    final userModel = await dataSource.signUp(email, password, nickname);
    return userModel; //! Автоматическое приведение к UserEntity через наследование
  }

  @override
  Future<UserEntity> signIn(String email, String password) async {
    final userModel = await dataSource.signIn(email, password);
    return userModel; 
  }

  @override
  Future<void> signOut() async {
    return await dataSource.signOut();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userModel = await dataSource.getCurrentUser();
    return userModel;
  }
}