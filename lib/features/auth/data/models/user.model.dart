import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable()
class UserModel {
  const UserModel({required this.id, required this.email});

  final String id;
  final String email;

  factory UserModel.fromFirebaseUser(User user) => UserModel(
        id: user.uid,
        email: user.email ?? '',
      );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
