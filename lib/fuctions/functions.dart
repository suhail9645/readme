import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:read_me/widgets/widgets.dart';
import '../admin/add_page.dart';
import '../home_section/home.dart';

class ClassFunctions {
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
        if (user != null) {
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
  static Future<void> register(
      String email, String password,String username,BuildContext context) async {
    final auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
          final FirebaseFirestore _firestore = FirebaseFirestore.instance;
          _firestore.collection('user').doc(userCredential.user!.uid).set({
            'username':username
          });

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
      }else{
         ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar(contentText: 'something wrong'));
      }
    }
  }
  
}
