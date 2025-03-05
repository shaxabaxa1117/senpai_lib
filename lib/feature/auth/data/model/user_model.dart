// features/auth/data/models/user_model.dart


import 'package:senpai_lib/feature/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
 UserModel({required super.id, required super.nickname});


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
    };
  }

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      nickname: entity.nickname,
    );
  }
}