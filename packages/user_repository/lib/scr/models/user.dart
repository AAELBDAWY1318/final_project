import 'package:equatable/equatable.dart';
import 'package:user_repository/scr/entities/user_entity.dart';

class MyUser extends Equatable {
  final String userId;
  final String email;
  final String name;
  String? flag;

  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    this.flag,
  });

  /// Empty user which represents an unauthenticated user.
  static final empty = MyUser(
      userId: '',
      email: '',
      name: '',
      flag: ''
  );

  /// Modify MyUser parameters
  MyUser copyWith({
    String? userId,
    String? email,
    String? name,
    String? flag,
  }) {
    return MyUser(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      flag: flag ?? this.flag,
    );
  }

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == MyUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != MyUser.empty;

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      flag: flag,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      flag: entity.flag,
    );
  }


  @override
  List<Object?> get props => [userId, email, name, flag];

}
