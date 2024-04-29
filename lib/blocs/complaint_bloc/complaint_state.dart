part of 'complaint_bloc.dart';

sealed class ComplaintState extends Equatable {
  const ComplaintState();

  @override
  List<Object> get props => [];
}


final class ComplaintInitial extends ComplaintState {}

class AddComplaintProcess extends ComplaintState {}
class AddComplaintSuccess extends ComplaintState {}
class AddComplaintFailure extends ComplaintState {}

class GetComplaintProcess extends ComplaintState {}
class GetComplaintSuccess extends ComplaintState {
  final List<Complaint> complaints;

  const GetComplaintSuccess({required this.complaints});
}
class GetComplaintFailure extends ComplaintState {}

class RemoveComplaintProcess extends ComplaintState{}
class RemoveComplaintSuccess extends ComplaintState{}
class RemoveComplaintFailure extends ComplaintState{}




