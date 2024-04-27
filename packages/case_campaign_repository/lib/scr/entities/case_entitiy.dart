import 'package:equatable/equatable.dart';

class CaseEntity extends Equatable {
  final String caseId;
  final String name;
  final String phone;
  final String description;
  final String idImage1;
  final String idImage2;
  final String category;
  final String allAmount;
  final String getAmount;

  const CaseEntity(
      {required this.caseId,
      required this.name,
      required this.phone,
      required this.description,
      required this.idImage1,
      required this.idImage2,
      required this.category,
      required this.allAmount,
      required this.getAmount});

  Map<String, Object?> toDocument() {
    return {
      'caseId': caseId,
      'name': name,
      'phone': phone,
      'description': description,
      'idImage1': idImage1,
      'idImage2': idImage2,
      'category': category,
      'allAmount': allAmount,
      'getAmount': getAmount,
    };
  }

  static CaseEntity fromDocument(Map<String, dynamic> doc) {
    return CaseEntity(
        caseId: doc['caseId'] as String,
        name: doc['name'] as String,
        phone: doc['phone'] as String,
        description: doc['description'] as String,
        idImage1: doc['idImage1'] as String,
        idImage2: doc['idImage2'] as String,
        category: doc['category'] as String,
        allAmount: doc['allAmount'] as String,
        getAmount: doc['getAmount'] as String);
  }

  @override
  List<Object?> get props => [
        caseId,
        name,
        phone,
        description,
        idImage1,
        idImage2,
        category,
        allAmount,
        getAmount
      ];
}
