import 'package:mangatek_flutter/core/data/mappers/mappers.dart';
import 'package:mangatek_flutter/features/auth/data/models/user.model.dart';
import 'package:mangatek_flutter/features/auth/domain/entities/user.entity.dart';

class UserMapper implements MapperTo<UserEntity, UserModel>, MapperFrom<UserModel, UserEntity> {
  const UserMapper();

  @override
  UserEntity toEntity(UserModel model) => UserEntity(id: model.id, email: model.email);

  @override
  UserModel fromEntity(UserEntity entity) => UserModel(id: entity.id, email: entity.email);
}
