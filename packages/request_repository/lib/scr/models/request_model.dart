import 'package:equatable/equatable.dart';
import 'package:request_repository/scr/entities/request_entity.dart';

class Request extends Equatable {
  final String nationalId;
  final String name;
  final String idImage1;
  final String idImage2;
  final String phone;
  final String description;
  final String status;
  final String flag;

  const Request(
      {required this.name,
      required this.phone,
      required this.nationalId,
      required this.description,
      required this.idImage1,
      required this.idImage2,
      required this.status,
      required this.flag});

  Request edit({
    String? nationalId,
    String? name,
    String? idImage1,
    String? idImage2,
    String? phone,
    String? description,
    String? status,
    String ? flag,
  }) {
    return Request(
      phone: phone ?? this.phone,
      name: name ?? this.name,
      nationalId: nationalId ?? this.nationalId,
      idImage1: idImage1 ?? this.idImage1,
      idImage2: idImage2 ?? this.idImage2,
      description: description ?? this.description,
      status: status ?? this.status,
      flag: flag ?? this.flag,
    );
  }
  //empty object
  static Request empty = const Request(
    name: '',
    status: '',
    description: '',
    idImage2: '',
    idImage1: '',
    nationalId: '',
    phone: '',
    flag: '',
  );

  RequestEntity toEntity(){
    return RequestEntity(
      status: status,
      description: description,
      phone: phone,
      nationalId: nationalId,
      idImage1: idImage1,
      idImage2: idImage2,
      name: name,
      flag :flag
    );
  }

  static Request fromEntity(RequestEntity entity){
    return Request(
      name:  entity.name,
      nationalId: entity.nationalId,
      idImage2: entity.idImage2,
      idImage1: entity.idImage1,
      phone: entity.phone,
      description: entity.description,
      status: entity.status,
      flag : entity.flag,
    );
  }
  @override
  List<Object?> get props => [name , nationalId , idImage1 , idImage2 , phone , description , status, flag];
}
