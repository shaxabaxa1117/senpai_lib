import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String nickname;

  UserEntity({required this.id, required this.nickname});

  @override
  List<Object?> get props => [id, nickname];
}
