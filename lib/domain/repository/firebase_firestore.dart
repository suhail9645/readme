import 'package:hive_flutter/hive_flutter.dart';
import 'package:read_me/domain/model/model_story.dart';

abstract class FirebaseStoryOperations{
  Future<Box<Story>>getAllStory();
}
abstract class FireStoreUserOperations{
  Future<void>getAllUserDetails(String uid);
}

