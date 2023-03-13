import 'package:flutter/material.dart';
import 'package:read_me/fuctions/functions.dart';
import 'package:read_me/home_section/category_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/model_story.dart';

class Variables {
  static  List<Widget> modelCategory = [
    CategoryModel(image: 'assets/romance.jfif', name: 'Romance', category: ClassFunctions.romance,),
    CategoryModel(image: 'assets/history.jfif', name: 'History', category: ClassFunctions.history,),
    CategoryModel(image: 'assets/fitness.jfif', name: 'Fitness', category: ClassFunctions.fitness,),
    CategoryModel(image: 'assets/horror.jfif', name: 'Horror', category: ClassFunctions.horror,),
    CategoryModel(image: 'assets/download_2.jfif', name: 'Others', category: ClassFunctions.other,),
    CategoryModel(image: 'assets/thriler.jfif', name: 'Thriller', category: ClassFunctions.thriller,),
    CategoryModel(image: 'assets/motivation.png', name: 'Motivation', category: ClassFunctions.motivation,),
    CategoryModel(image: 'assets/adventure.jfif', name: 'Adventure', category: ClassFunctions.adventure),
  ];
  static TextStyle mStyle =
      GoogleFonts.poppins(fontSize: 18, color: Colors.white);
  static TextStyle sStyle =
      GoogleFonts.poppins(fontSize: 12, color: Colors.white);

      static ValueNotifier<bool>onTap=ValueNotifier(true);
      static ValueNotifier<ValueNotifier<List<Story>>>category=ValueNotifier(ClassFunctions.adventure);
      
   static const Color mColor=Color.fromARGB(255, 9, 60, 106);   
   static String? userEmail;
   static String? userName;
}
