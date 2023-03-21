import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:read_me/home_section/home.dart';
import 'package:read_me/home_section/variables.dart';
import 'package:read_me/model_file/model_file.dart';
import 'package:read_me/widgets/widgets.dart';
import '../admin/add_page.dart';
import '../home_section/home_two.dart';
import '../model/model_story.dart';
import '../welcome.dart';
import 'package:file_picker/file_picker.dart';

class ClassFunctions {
  //login function
  static Future<void> login(
      String email, String password, BuildContext context) async {
    if (email == dotenv.env['EMAIL'] && password == dotenv.env['PASSWORD']) {
      adminIsLog(true, context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => AddPage(),
          ),
          (route) => false);
    } else {
      try {
        final auth = FirebaseAuth.instance;
        UserCredential user = await auth.signInWithEmailAndPassword(
            email: email, password: password);

        if (auth.currentUser != null) {
          Variables.userEmail = auth.currentUser!.email!;

          final Query query = FirebaseFirestore.instance.collection('user');
          final QuerySnapshot querySnapshot = await query.get();
          for (var element in querySnapshot.docs) {
            if (element.id == auth.currentUser!.uid) {
              Variables.userName = element.get('username');
              break;
            }
          }

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => FirstHome(),
              ),
              (route) => false);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(contentText: 'Invalid email or password'));
      }
    }
  }

// register function
  static Future<void> register(String email, String password, String username,
      BuildContext context) async {
    final auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      _firestore
          .collection('user')
          .doc(userCredential.user!.uid)
          .set({'username': username});

      if (userCredential != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomePageTwo(),
            ),
            (route) => false);
      }
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
  }

// refreshing function ,feching in firebase and add to hive
  static Future<Box<Story>> getdata() async {
    final storyDb = await Hive.openBox<Story>('story');
    final Query query = FirebaseFirestore.instance.collection('story');
    final QuerySnapshot querySnapshot = await query.get();
    for (int element = 0; element < querySnapshot.docs.length; element++) {
      Map<String, dynamic> data =
          querySnapshot.docs[element].data() as Map<String, dynamic>;

      final story = Story(
        storyname: data['storyName'],
        authorname: data['authorName'],
        story: data['story'],
        category: data['category'],
        image: data['image'],
        firUid: querySnapshot.docs[element].id,
        isFavorite: false,
      );
      bool flag = true;
      for (var element in storyDb.values) {
        if (element.firUid == story.firUid) {
          flag = false;
        }
      }
      if (flag) {
        story.id = await storyDb.add(story);
        await storyDb.put(story.id, story);
      }
    }
    return storyDb;
  }

// adding and deleting favorite
  static Future<void> addFavorite(Story favorite) async {
    final storyDb = await Hive.openBox<Story>('story');
    favorite.isFavorite = !favorite.isFavorite;
    storyDb.put(favorite.id, favorite);
  }

// admin loging and logout
  static Future<void> adminIsLog(bool value, BuildContext context) async {
    final adminDb = await Hive.openBox<bool>('admin');
    adminDb.put(0, value);
    Hive.close();
  }

  // Splash screen function checking user or admin ,is already logged in
  static Future<void> splash(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    final adminDb = await Hive.openBox('admin');
    bool? value = adminDb.get(0);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => WelcomePage(
        value: value,
      ),
    ));
    Hive.close();
  }

// This for seprating stories from hive
  static List<Story> sepratingStory(Box<Story> boxStory, String category) {
    List<Story> storyList = boxStory.values.toList();
    List<Story> categoryStory = [];
    for (var element in storyList) {
      if (element.category == category) {
        categoryStory.add(element);
      }
    }
    return categoryStory;
  }

// This function for picking in phone and adding in to hive
  static Future<void> fileSelection() async {
    final fileDb = await Hive.openBox<FileCollection>('files');
    final result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['pdf'],
        allowMultiple: false,
        type: FileType.custom);
    if (result != null) {
      String extension = result.paths.first!.split('.').last;
      String name = result.names.first!;
      File pdf = File(result.files.first.path!);
      String date = DateTime.now().toString().split('.').first;
      if (extension.toLowerCase() == 'pdf') {
        final file = FileCollection(name, pdf.path, date);
        file.id = await fileDb.add(file);
        fileDb.put(file.id, file);
        //  Hive.close();
      }
    }
  }

// This function for delete file from Hive
  static Future<void> deleteFile(int index) async {
    final fileDb = await Hive.openBox<FileCollection>('files');
    fileDb.deleteAt(index);
  }

  // This function for seprating favorite stories in Hive
  static List<Story> favoriteGet(Box<Story> boxStory) {
    List<Story> storyList = boxStory.values.toList();

    List<Story> categoryStory = [];
    for (var element in storyList) {
      if (element.isFavorite) {
        categoryStory.add(element);
      }
    }
    return categoryStory;
  }
}
