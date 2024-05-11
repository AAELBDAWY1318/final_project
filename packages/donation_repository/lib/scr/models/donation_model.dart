
import 'package:donation_repository/scr/entities/donation_entity.dart';
import 'package:equatable/equatable.dart';

class DonationModel extends Equatable {
  final String userId;
  final String caseId;
  final String donationAmount;
  final String managementCost;
  final String category;
  final String date ;
  final String time ;

  const DonationModel({
    required this.userId,
    required this.caseId,
    required this.donationAmount,
    required this.managementCost,
    required this.category,
    required this.time,
    required this.date,
  });

  static DonationModel fromEntity(DonationEntity entity) {
    return DonationModel(
      userId: entity.userId,
      caseId: entity.caseId,
      donationAmount: entity.donationAmount,
      managementCost: entity.managementCost,
      category: entity.category,
      date: entity.date,
      time: entity.time,
    );
  }

  DonationEntity toEntity() {
    return DonationEntity(
      category: category,
      managementCost: managementCost,
      donationAmount: donationAmount,
      caseId: caseId,
      userId: userId,
      time: time ,
      date: date,
    );
  }

  DonationModel editUserId({
    String? userId,
    String? time,
    String ? date,
  }) {
    return DonationModel(
      userId: userId ?? this.userId,
      caseId: caseId,
      donationAmount: donationAmount,
      managementCost: managementCost,
      category: category,
      date: date ?? this.date ,
      time: time ?? this.time,
    );
  }

  @override
  List<Object?> get props =>
      [time , date , userId, caseId, donationAmount, managementCost, category];
}
