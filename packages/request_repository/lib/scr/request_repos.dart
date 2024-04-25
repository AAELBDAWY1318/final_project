import 'package:request_repository/request_repository.dart';

abstract class RequestRepository{
  Future<void> addRequest(Request request);

  Future<List<Request>> getRealRequest();

  Future<List<Request>> getFakeRequest();

  Future<void> updateRequest(Request request);

  Future<String> getRequestStatus(String requestId);
}