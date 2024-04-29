import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:equatable/equatable.dart';

class CampaignModel extends Equatable {
  final String title;
  final String description;
  final String photo;
  final String collectedAmount;
  final String allAmount;

  const CampaignModel({
    required this.title,
    required this.description,
    required this.photo,
    required this.allAmount,
    required this.collectedAmount,
  });

  CampaignEntity toEntity() {
    return CampaignEntity(
        title: title,
        description: description,
        photo: photo,
        allAmount: allAmount,
        collectedAmount: collectedAmount);
  }

  static CampaignModel fromEntity(CampaignEntity entity) {
    return CampaignModel(
        title: entity.title,
        description: entity.description,
        photo: entity.photo,
        allAmount: entity.allAmount,
        collectedAmount: entity.collectedAmount);
  }

  CampaignModel edit({
    String? title,
    String? description,
    String? photo,
    String? collectedAmount,
    String? allAmount,
  }) {
    return CampaignModel(
        title: title ?? this.title,
        description: description ?? this.description,
        photo: photo ?? this.photo,
        allAmount: allAmount ?? this.allAmount,
        collectedAmount: collectedAmount ?? this.collectedAmount);
  }

  @override
  List<Object?> get props =>
      [title, description, photo, allAmount, collectedAmount];
}
