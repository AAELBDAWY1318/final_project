import 'package:equatable/equatable.dart';

class DonationEntity extends Equatable {
  final String userId;
  final String caseId;
  final String donationAmount;
  final String managementCost;
  final String category;

  const DonationEntity({
    required this.userId,
    required this.caseId,
    required this.donationAmount,
    required this.managementCost,
    required this.category,
  });

  static DonationEntity fromDocument(Map<String, dynamic> doc) {
    return DonationEntity(
        userId: doc["userId"] as String,
        caseId: doc["caseId"] as String,
        donationAmount: doc["donationAmount"] as String,
        managementCost: doc["managementCost"] as String,
        category: doc["category"] as String);
  }

  Map<String, Object?> toDocument(){
    return{
      "userId":userId,
      "caseId":caseId,
      "donationAmount":donationAmount,
      "managementCost":managementCost,
      "category":category,
    };
  }
  @override
  List<Object?> get props =>
      [userId, caseId, donationAmount, managementCost, category];
}
