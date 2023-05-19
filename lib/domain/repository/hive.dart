import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserHiveOperations{
  Future<String?>getUserDetailes();
  Future<void>addUserDatailes(String value);
}

abstract class UserProfileHive{
  Future<void>addProfileIntoHIve(QueryDocumentSnapshot userData);
}