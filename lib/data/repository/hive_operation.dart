import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:read_me/core/strings.dart';
import 'package:read_me/domain/repository/hive.dart';

import '../../domain/model_user.dart/model_user.dart';

class HiveOperationsImp extends UserHiveOperations {
  @override
  Future<String?> getUserDetailes() async {
    final userDb = await Hive.openBox<String>(userHive);
    String? value = userDb.get(0);
    userDb.close();
    return value;
  }

  @override
  Future<void> addUserDatailes(String value) async {
    final userDb = await Hive.openBox<String>(userHive);
    userDb.put(0, value);
  }
}

class HiveUserProfileImp extends UserProfileHive {
  @override
  Future<void> addProfileIntoHIve(
      QueryDocumentSnapshot<Object?> userData) async {
    final userDb = await Hive.openBox<UserData>('userDetailes');

    UserData user = UserData(
        uid: userData.id,
        userName: userData.get('userName'),
        fullName: userData.get('fullName'),
        imageUrl: userData.get('imageUrl'));

    await userDb.add(user);
  }
}
