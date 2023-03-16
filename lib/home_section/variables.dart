import 'package:flutter/material.dart';
import 'package:read_me/fuctions/functions.dart';
import 'package:read_me/home_section/category_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/model_story.dart';

class Variables {
  static  List<Widget> modelCategory =const [
    CategoryModel(image: 'assets/romance.jfif', name: 'Romance' ),
    CategoryModel(image: 'assets/history.jfif', name: 'History'),
    CategoryModel(image: 'assets/fitness.jfif', name: 'Fitness'),
    CategoryModel(image: 'assets/horror.jfif', name: 'Horror' ),
    CategoryModel(image: 'assets/download_2.jfif', name: 'Others'),
    CategoryModel(image: 'assets/thriler.jfif', name: 'Thriller',),
    CategoryModel(image: 'assets/motivation.png', name: 'Motivation'),
    CategoryModel(image: 'assets/adventure.jfif', name: 'Adventure'),
  ];
  static TextStyle mStyle =
      GoogleFonts.poppins(fontSize: 18, color: Colors.white);
  static TextStyle sStyle =
      GoogleFonts.poppins(fontSize: 12, color: Colors.white);

      static ValueNotifier<bool>onTap=ValueNotifier(true);
      
   static const Color mColor=Color.fromARGB(255, 9, 60, 106);   
   static String? userEmail;
   static String? userName;
   static ValueNotifier<int>bottemIndex=ValueNotifier(0);
}
