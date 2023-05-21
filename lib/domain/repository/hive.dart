import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:read_me/domain/model/model_story.dart';
import 'package:read_me/domain/model_file/model_file.dart';

import '../model_user.dart/model_user.dart';

abstract class UserHiveOperations{
  Future<String?>getUserDetailes();
  Future<void>addUserDatailes(String value);
}

abstract class UserProfileHive{
  Future<void>addProfileIntoHIve(QueryDocumentSnapshot userData);
  Future<UserData>getCurrentUserProfile();
}

abstract class FavouriteHive{
 Future<List<Story>>getAllFavourite();
 Future<void>addAndRemoveFavourite(Story favorite, BuildContext context);
 }

abstract class FileHive{
  Future<List<FileCollection>>getAllFiles();
  Future<void>deleteFileFromHive(int index,BuildContext context);
}

