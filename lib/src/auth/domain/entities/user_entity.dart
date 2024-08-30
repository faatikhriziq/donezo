import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;

  const UserEntity(
    this.photoUrl, {
    required this.id,
    required this.email,
    required this.name,
  });

  factory UserEntity.fromFirebaseUser(User? user) {
    return UserEntity(
      user?.photoURL,
      id: user?.uid ?? '',
      email: user?.email ?? '',
      name: user?.displayName ?? '',
    );
  }

  factory UserEntity.fromUserInfo(List<UserInfo> map) {
    return UserEntity(
      map[0].photoURL,
      id: map[0].uid ?? '',
      email: map[0].email ?? '',
      name: map[0].displayName ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        photoUrl
      ];
}
