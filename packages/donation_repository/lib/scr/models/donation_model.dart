
import 'package:donation_repository/scr/entities/donation_entity.dart';
import 'package:equatable/equatable.dart';

class DonationModel extends Equatable {
  final String userId;
  final String caseId;
  final String donationAmount;
  final String managementCost;
  final String category;

  const DonationModel({
    required this.userId,
    required this.caseId,
    required this.donationAmount,
    required this.managementCost,
    required this.category,
  });

  static DonationModel fromEntity(DonationEntity entity) {
    return DonationModel(
      userId: entity.userId,
      caseId: entity.caseId,
      donationAmount: entity.donationAmount,
      managementCost: entity.managementCost,
      category: entity.category,
    );
  }

  DonationEntity toEntity() {
    return DonationEntity(
      category: category,
      managementCost: managementCost,
      donationAmount: donationAmount,
      caseId: caseId,
      userId: userId,
    );
  }

  DonationModel editUserId({
    String? userId,
  }) {
    return DonationModel(
      userId: userId ?? this.userId,
      caseId: caseId,
      donationAmount: donationAmount,
      managementCost: managementCost,
      category: category,
    );
  }

  @override
  List<Object?> get props =>
      [userId, caseId, donationAmount, managementCost, category];
}
