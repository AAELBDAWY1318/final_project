part of 'complaint_bloc.dart';

sealed class ComplaintEvent extends Equatable{
  const ComplaintEvent();
  @override
  List<Object> get props => [];
}

class AddComplaint extends ComplaintEvent {
  final Complaint complaint;

  const AddComplaint({required this.complaint});
}

class GetComplaint extends ComplaintEvent {
  const GetComplaint();
}

class RemoveComplaintEvent extends ComplaintEvent{
  final String id;

  const RemoveComplaintEvent({required this.id});
}
