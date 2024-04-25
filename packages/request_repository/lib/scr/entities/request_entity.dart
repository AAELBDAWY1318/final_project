import 'package:equatable/equatable.dart';

class RequestEntity extends Equatable {
  final String nationalId;
  final String name;
  final String idImage1;
  final String idImage2;
  final String phone;
  final String description;
  final String status;
  final String flag;

  const RequestEntity(
      {required this.name,
      required this.phone,
      required this.nationalId,
      required this.description,
      required this.idImage1,
      required this.idImage2,
      required this.status,
      required this.flag});

  Map<String, Object?> toDocument() {
    return {
      'nationalId': nationalId,
      'name': name,
      'idImage1': idImage1,
      'idImage2': idImage2,
      'phone': phone,
      'description': description,
      'status': status,
      'flag':flag,
    };
  }

  static RequestEntity fromDocument(Map<String, dynamic> doc) {
    return RequestEntity(
      nationalId: doc['nationalId'] as String,
      name: doc['name'] as String,
      idImage1: doc['idImage1'] as String,
      idImage2: doc['idImage2'] as String,
      phone: doc['phone'] as String,
      description: doc['description'] as String,
      status: doc['status'] as String,
      flag: doc['flag'] as String,
    );
  }

  @override
  List<Object?> get props =>
      [name, nationalId, idImage1, idImage2, phone, description, status , flag];
}
