import 'package:flutter/material.dart';

import '../home_section/variables.dart';

class CustomDecoration extends InputDecoration {
  CustomDecoration({required hint})
      : super(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: hint,
          hintStyle: Variables.sStyle,
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 9, 60, 106), width: 2)),
          contentPadding: const EdgeInsets.all(10),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        );
}
