import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:read_me/home_section/variables.dart';

import '../home_section/home_two.dart';
import '../widgets/widgets.dart';

class RegisterFunction {
  static Future<File?> imagePicking(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      return File(image.path);
    }
  }

  static Future<String?> register(
      String email,
      String password,
      String username,
      String fullName,
      File? photo,
      String? extension,
      BuildContext context) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    String? imageUrl;
    String? oldUser;
    bool isNewUser = true;
    final QuerySnapshot userDatas = await firestore.collection('user').get();
    for (var element in userDatas.docs) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      if (data['userName'] == username) {
        isNewUser = false;
        oldUser = data['userName'];
        break;
      }
    }
    if (isNewUser == true) {
      final auth = FirebaseAuth.instance;
      try {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email, password: password);
        if (photo != null) {
          final fireStore = FirebaseStorage.instance
              .ref()
              .child('$username/image.$extension');
          await fireStore.putFile(photo);
          imageUrl = await fireStore.getDownloadURL();
        }
        firestore.collection('user').doc(userCredential.user!.uid).set(
            {'userName': username, 'fullName': fullName, 'imageUrl': imageUrl});
        getUserDetailes(userCredential);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomePageTwo(),
            ),
            (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(contentText: 'This Email already in use'));
        } else if (e.code == 'invalid-email') {
          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBar(contentText: 'Invalid email'));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBar(contentText: 'something wrong'));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(contentText: 'This Username already in use'));
      return oldUser;
    }
  }

  static Future<void> getUserDetailes(UserCredential userCredential) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final QuerySnapshot userDatas = await firestore.collection('user').get();
    for (var element in userDatas.docs) {
      if (element.id == userCredential.user!.uid) {
        final userDb = await Hive.openBox<String>('userDetailes');
        userDb.add(element.get('fullName'));
        userDb.add(element.get('userName'));
        userDb.add(element.get('imageUrl'));
        Variables.userName=element.get('userName');
        Variables.userfullName=element.get('fullName');
        Variables.userProfile=element.get('imageUrl');
      }
    }
  }
}
