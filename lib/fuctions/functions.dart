import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:read_me/home_section/variables.dart';
import 'package:read_me/widgets/widgets.dart';
import '../admin/add_page.dart';
import '../home_section/home.dart';
import '../model/model_story.dart';

class ClassFunctions {
  static ValueNotifier<List<Story>> romance = ValueNotifier([]);
  static ValueNotifier<List<Story>> history = ValueNotifier([]);
  static ValueNotifier<List<Story>> fitness = ValueNotifier([]);
  static ValueNotifier<List<Story>> horror = ValueNotifier([]);
  static ValueNotifier<List<Story>> thriller = ValueNotifier([]);
  static ValueNotifier<List<Story>> motivation = ValueNotifier([]);
  static ValueNotifier<List<Story>> adventure = ValueNotifier([]);
  static ValueNotifier<List<Story>> topten = ValueNotifier([]);
  static ValueNotifier<List<Story>> trend = ValueNotifier([]);
  static ValueNotifier<List<Story>> newly = ValueNotifier([]);
  static ValueNotifier<List<Story>> best = ValueNotifier([]);
  static ValueNotifier<List<Story>> other = ValueNotifier([]);
  static List<ValueNotifier<List<Story>>> category = [
    romance,
    history,
    fitness,
    horror,
    thriller,
    motivation,
    adventure,
    topten,
    trend,
    newly,
    best,
    other
  ];
  //login function
  static Future<void> login(
      String email, String password, BuildContext context) async {
    if (email == dotenv.env['EMAIL'] && password == dotenv.env['PASSWORD']) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddPage(),
      ));
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
                builder: (context) => const HomePage(),
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
              builder: (context) => const HomePage(),
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

  static Future<void> getdata() async {
    await Hive.openBox<Story>('story');
    await Hive.deleteBoxFromDisk('story');
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
          image: data['image']);

      story.id = await storyDb.add(story);
      await storyDb.put(story.id, story);
    }
    getAllFromHive();
  }

  static Future<void> getAllFromHive() async {
    final storyDb = await Hive.openBox<Story>('story');
    for (var element in category) {
      element.value.clear();
    }
    for (var element in storyDb.values) {
      if (element.category == 'Romance') {
        romance.value.add(element);
      } else if (element.category == 'History') {
        history.value.add(element);
      } else if (element.category == 'Fitness') {
        fitness.value.add(element);
      } else if (element.category == 'Horror') {
        horror.value.add(element);
      } else if (element.category == 'Thriller') {
        thriller.value.add(element);
      } else if (element.category == 'Motivation') {
        motivation.value.add(element);
      } else if (element.category == 'Adventure') {
        adventure.value.add(element);
      } else if (element.category == 'Top 10') {
        topten.value.add(element);
      } else if (element.category == 'Trending now') {
        trend.value.add(element);
      } else if (element.category == 'Newly published') {
        newly.value.add(element);
      } else if (element.category == 'Best seller') {
        best.value.add(element);
      } else if (element.category == 'Other') {
        other.value.add(element);
      }
    }
  }
}
