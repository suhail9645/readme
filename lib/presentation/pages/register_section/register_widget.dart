import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFormDecoration extends InputDecoration {
  const CustomFormDecoration({required hint})
      : super(
            hintText: hint,
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 9, 60, 106), width: 2)),
            contentPadding: const EdgeInsets.all(10),
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ));
}

class CustomText extends Padding {
  CustomText({super.key, required super.padding, required text})
      : super(
          child: Text(
            text,
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        );
}
