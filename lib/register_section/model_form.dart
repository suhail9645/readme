import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class ModelForm extends StatelessWidget {
  final String headertext;
  final String hinttext;
   TextEditingController?  formcontroller;
 
   ModelForm({super.key, required this.headertext, required this.hinttext, this.formcontroller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
                padding: const EdgeInsets.fromLTRB(14,10,5,0),
                child: Text(headertext,style: GoogleFonts.poppins(color: Colors.white),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,4,10,4),
                child: TextFormField(
                  controller:formcontroller ,
                  decoration: InputDecoration(
                    hintText: hinttext,
                      focusedBorder:const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 9, 60, 106),
                              width: 2)),
                      contentPadding:const EdgeInsets.all(10),
                      filled: true,
                      fillColor: Colors.white,
                      border:const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      )),
                      validator: (value) {
                        if(value==null||value.isEmpty){
                          return 'This field is required';
                        }return null;
                      },
                ),
              ),
      ],
    );
  }
}