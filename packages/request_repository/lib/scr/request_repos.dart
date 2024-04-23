import 'dart:io';
import 'package:request_repository/scr/models/request_model.dart';

abstract class RequestRepository{
  Future<void> addRequest(Request request);
}