import 'package:case_campaign_repository/scr/entities/case_entitiy.dart';
import 'package:equatable/equatable.dart';

class CaseModel extends Equatable {
  final String caseId;
  final String name;
  final String phone;
  final String description;
  final String idImage1;
  final String idImage2;
  final String category;
  final String allAmount;
  final String getAmount;

  const CaseModel(
      {required this.caseId,
      required this.name,
      required this.phone,
      required this.description,
      required this.idImage1,
      required this.idImage2,
      required this.category,
      required this.allAmount,
      required this.getAmount});

  CaseEntity toEntity() {
    return CaseEntity(
        caseId: caseId,
        name: name,
        phone: phone,
        description: description,
        idImage1: idImage1,
        idImage2: idImage2,
        category: category,
        allAmount: allAmount,
        getAmount: getAmount);
  }

  static CaseModel empty() => const CaseModel(
      caseId: '',
      name: '',
      phone: '',
      description: '',
      idImage1: '',
      idImage2: '',
      category: '',
      allAmount: '',
      getAmount: '');

  static CaseModel fromEntity(CaseEntity entity) {
    return CaseModel(
        caseId: entity.caseId,
        name: entity.name,
        phone: entity.phone,
        description: entity.description,
        idImage1: entity.idImage1,
        idImage2: entity.idImage2,
        category: entity.category,
        allAmount: entity.allAmount,
        getAmount: entity.getAmount);
  }

  CaseModel edit({
    String? name,
    String? caseId,
    String? phone,
    String? description,
    String? idImage1,
    String? idImage2,
    String? category,
    String? allAmount,
    String? getAmount,
  }) {
    return CaseModel(
        caseId: caseId ?? this.caseId,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        description: description ?? this.description,
        idImage1: idImage1 ?? this.idImage1,
        idImage2: idImage2 ?? this.idImage2,
        category: category ?? this.category,
        allAmount: allAmount ?? this.allAmount,
        getAmount: getAmount ?? this.getAmount);
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
