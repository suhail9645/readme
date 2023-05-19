import 'package:dartz/dartz.dart';
import 'package:read_me/data/models/failure_model.dart';

abstract class FirebaseUserOperations {
  Future<Either<Failure,bool>>checkUser(String email, String password);
}