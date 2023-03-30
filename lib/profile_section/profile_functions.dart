import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:read_me/profile_section/profile.dart';
import 'package:read_me/register_section/register_functions.dart';
import '../model_user.dart/model_user.dart';
import '../widgets/widgets.dart';

class ProfileFunction {
  static Future updateUser(String username, String fullName, File? photo,
      String? extension, BuildContext context, UserData user) async {
    String? imageUrl=user.imageUrl;
    bool isNewUser = true;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userData = await firestore.collection('user').get();
    for (var element in userData.docs) {
      Map<String, dynamic> data = element.data();
      if (data['userName'] == username&&username!=user.userName) {
        isNewUser = false;
        break;
      }
    }
    if (isNewUser) {
      if (photo != null) {
        final fireRef=FirebaseStorage.instance.ref().child(user.userName);
        fireRef.delete();
        final fireStorage = FirebaseStorage.instance
            .ref()
            .child('$username/image.$extension');
        await fireStorage.putFile(photo);
        imageUrl = await fireStorage.getDownloadURL();
      }
      firestore.collection('user').doc(user.uid).set(
          {'userName': username, 'fullName': fullName,'imageUrl': imageUrl});
      RegisterFunction.getUserDetailes(user.uid)
          .whenComplete(() => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) =>const ProfilePage(),
              ),
              (route) => route.isFirst,),);
    }
    else{
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
                                      CustomSnackBar(
                                        contentText:'This username already using one'));
    }
  }
}
