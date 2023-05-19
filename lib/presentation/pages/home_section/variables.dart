import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widget/category_model.dart';

class Variables {
  static TextStyle mStyle =
      GoogleFonts.poppins(fontSize: 18, color: Colors.white);
  static TextStyle sStyle =
      GoogleFonts.poppins(fontSize: 12, color: Colors.white);
      static ValueNotifier<bool>onTap=ValueNotifier(true);   
   static const Color mColor=Color.fromARGB(255, 9, 60, 106);   
   static ValueNotifier<int>bottemIndex=ValueNotifier(0);
   static const Color appBackground= Color.fromARGB(255, 46, 47, 55);
   static ValueNotifier <String>searchvalue=ValueNotifier('');
   static ValueNotifier<String> categoryName = ValueNotifier('');
}
