import 'package:complaint_repository/complaint_repository.dart';
import 'package:complaint_repository/scr/entities/complaint_entity.dart';
import 'package:equatable/equatable.dart';

class Complaint extends Equatable {
  final String userId;
  final String title;
  final String phone;
  final String description;

  const Complaint(
      {required this.userId,
      required this.title,
      required this.phone,
      required this.description});
  // convert the model to entity
  ComplaintEntity toEntity() {
    return ComplaintEntity(
      userId: userId,
      title: title,
      phone: phone,
      description: description,
    );
  }

  Complaint edit({
    String? userId,
    String? title,
    String? phone,
    String? description,
  }) {
    return Complaint(
      userId: userId ?? this.userId,
      title: title ?? this.title,
      phone: phone ?? this.phone,
      description: description ?? this.description,
    );
  }

  // covert entity to model
  static Complaint fromEntity(ComplaintEntity entity) {
    return Complaint(
      userId: entity.userId,
      title: entity.title,
      phone: entity.phone,
      description: entity.description,
    );
  }

  @override
  List<Object?> get props => [userId, title, phone, description];
}
