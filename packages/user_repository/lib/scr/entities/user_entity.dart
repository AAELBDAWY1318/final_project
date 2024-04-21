import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String userId;
  final String email;
  final String name;
  final String? flag;

  const MyUserEntity({
    required this.userId,
    required this.email,
    required this.name,
    this.flag,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': userId,
      'email': email,
      'name': name,
      'flag': flag,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
        userId: doc['id'] as String,
        email: doc['email'] as String,
        name: doc['name'] as String,
        flag: doc['flag'] as String?
    );
  }

  @override
  List<Object?> get props => [userId, email, name, flag];

  @override
  String toString() {
    return '''UserEntity: {
      userId: $userId
      email: $email
      name: $name
      flag: $flag
    }''';
  }
}