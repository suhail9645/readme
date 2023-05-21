import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:read_me/domain/model/model_story.dart';

import '../model_user.dart/model_user.dart';

abstract class FirebaseStoryOperations{
  Future<Box<Story>>getAllStory();
}
abstract class FireStoreUserOperations{
  Future<void>getAllUserDetails(String uid);
  Future<void>updateUserProfile(UserData user,BuildContext context,String extension,String oldUserName);
}

