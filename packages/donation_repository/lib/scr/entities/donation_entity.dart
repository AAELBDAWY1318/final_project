import 'package:equatable/equatable.dart';

class DonationEntity extends Equatable {
  final String userId;
  final String caseId;
  final String donationAmount;
  final String managementCost;
  final String category;
  final String date;
  final String time;

  const DonationEntity({
    required this.userId,
    required this.caseId,
    required this.donationAmount,
    required this.managementCost,
    required this.category,
    required this.time,
    required this.date,
  });
  static DonationEntity fromDocument(Map<String, dynamic> doc) {
    return DonationEntity(
      userId: doc["userId"] as String,
      caseId: doc["caseId"] as String,
      donationAmount: doc["donationAmount"] as String,
      managementCost: doc["managementCost"] as String,
      category: doc["category"] as String,
      time: doc["time"] as String,
      date: doc["date"] as String,
    );
  }

  Map<String, Object?> toDocument() {
    return {
      "userId": userId,
      "caseId": caseId,
      "donationAmount": donationAmount,
      "managementCost": managementCost,
      "category": category,
      "time": time,
      "date": date,
    };
  }

  @override
  List<Object?> get props =>
      [time, date, userId, caseId, donationAmount, managementCost, category];
}
