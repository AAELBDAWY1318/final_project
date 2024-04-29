import 'package:equatable/equatable.dart';

class CampaignEntity extends Equatable {
  final String title;
  final String description;
  final String photo;
  final String collectedAmount;
  final String allAmount;

  const CampaignEntity({
    required this.title,
    required this.description,
    required this.photo,
    required this.allAmount,
    required this.collectedAmount,
  });

  Map<String, Object?> toDocument() {
    return {
      'title': title,
      'description': description,
      'photo': photo,
      'collectedAmount': collectedAmount,
      'allAmount': allAmount,
    };
  }

  static CampaignEntity fromDocument(Map<String, dynamic> doc) {
    return CampaignEntity(
        title: doc['title'] as String,
        description: doc['description'] as String,
        photo: doc['photo'] as String,
        allAmount: doc['allAmount'] as String,
        collectedAmount: doc['collectedAmount'] as String);
  }

  @override
  List<Object?> get props =>
      [title, description, photo, allAmount, collectedAmount];
}
