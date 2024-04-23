import 'package:equatable/equatable.dart';

class ComplaintEntity extends Equatable{
  final String userId;
  final String title;
  final String phone;
  final String description;

  const ComplaintEntity({
    required this.userId,
    required this.title,
    required this.phone,
    required this.description
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'title': title,
      'phone': phone,
      'description': description,
    };
  }

  static ComplaintEntity fromDocument(Map<String , dynamic> doc){
    return ComplaintEntity(
      userId: doc['userId'] as String,
      title: doc['title'] as String,
      phone: doc['phone'] as String ,
      description: doc['description'] as String,
    );
  }
  @override
  List<Object?> get props => [userId , title , phone , description];

}