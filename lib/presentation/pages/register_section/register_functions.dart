import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/functions/functions.dart';
import '../../../domain/model_user.dart/model_user.dart';
import '../main_page/home.dart';
import '../widgets/widgets.dart';

class RegisterFunction {
  static Future<File?> imagePicking(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      return File(image.path);
    }
    return null;
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
        getUserDetailes(userCredential.user!.uid);
        ClassFunctions.logedPerson('user');
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const FirstHome(),
            ),
            (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(contentText: 'This Email already in use'));
        } else if (e.code == 'invalid-email') {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBar(contentText: 'Invalid email'));
        } else if (e.code == 'weak-password') {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(contentText: 'Password should contain six words'));
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBar(contentText: 'something wrong'));
        }
      }
      return null;
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(contentText: 'This Username already in use'));
      return oldUser;
    }
  }

  static Future<void> getUserDetailes(String uid) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final QuerySnapshot userDatas = await firestore.collection('user').get();
    
    for (var element in userDatas.docs) {
      if (element.id == uid) {
        final userDb = await Hive.openBox<UserData>('userDetailes');

        UserData user = UserData(
            uid: uid,
            userName: element.get('userName'),
            fullName: element.get('fullName'),
            imageUrl: element.get('imageUrl'));

        await userDb.add(user);

        await getUserDetailesInValueNotifier();
      }
    }
  }

  static ValueNotifier<List<UserData>> userDetailes =
      userDetailes = ValueNotifier([]);
  static Future<void> getUserDetailesInValueNotifier() async {
    final userDb = await Hive.openBox<UserData>('userDetailes');

    userDetailes.value.addAll(userDb.values);
    userDetailes.notifyListeners();
  }

  static String? validateFunction(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
