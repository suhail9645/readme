import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:read_me/data/repository/hive_operation.dart';
import 'package:read_me/domain/model_user.dart/model_user.dart';
import 'package:read_me/domain/repository/firebase_firestore.dart';
import '../../presentation/pages/register_section/register_functions.dart';

class FireStoreUserImp extends FireStoreUserOperations {
  @override
  Future<QueryDocumentSnapshot?> getAllUserDetails(String uid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final QuerySnapshot userDatas = await firestore.collection('user').get();

    for (var element in userDatas.docs) {
      if (element.id == uid) {
        
        await RegisterFunction.getUserDetailesInValueNotifier();
        return element;
      }
    }
    return null;
  }

  @override
  Future<void> updateUserProfile(UserData user,BuildContext context,String extension,String oldUserName)async {
     String? imageUrl;
    bool isNewUser = true;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final usersData = await firestore.collection('user').get();
    for (var element in usersData.docs) {
      Map<String, dynamic> data = element.data();
      if (data['userName']!=oldUserName && data['userName'] == user.userName) {
        isNewUser = false;
        break;
      }
    }
    if(isNewUser){
        if (user.imageUrl != null) {
        final fireRef = FirebaseStorage.instance.ref().child(oldUserName);
        fireRef.delete();
        final fireStorage =
            FirebaseStorage.instance.ref().child('${user.userName}/image');
        await fireStorage.putFile(File(user.imageUrl!));
        imageUrl = await fireStorage.getDownloadURL();
      }
      firestore.collection('user').doc(user.uid).set(
          {'userName': user.userName, 'fullName': user.fullName, 'imageUrl': imageUrl});
         final updatedUserDetailes=await getAllUserDetails(user.uid);
       await  HiveUserProfileImp().addProfileIntoHIve(updatedUserDetailes!);

    }
  }
}
