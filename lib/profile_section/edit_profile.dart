import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_me/home_section/variables.dart';
import 'package:read_me/profile_section/custom.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();
    return Scaffold(
        backgroundColor: Variables.appBackground,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Variables.mColor,
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: Variables.mStyle,
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: 80,
                color: Variables.mColor,
                width: double.infinity,
              ),
              ListView(
                children: [
                   CircleAvatar(
                    backgroundColor: Colors.white,

                    radius: 80,
                    child: CircleAvatar(
                      radius: 75,
                      backgroundImage: NetworkImage(Variables.userProfile!),
                    ),
                  ),
                 
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 10, 5, 0),
                        child: Text(
                          'Change Fullname',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white,fontSize: 17),
                      controller: _name..text=Variables.userfullName!,
                          decoration: CustomDecoration(hint: 'enter name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 10, 5, 0),
                        child: Text(
                          'Change username',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                        child: TextFormField(
                           style: const TextStyle(color: Colors.white,fontSize: 17),
                           controller: _username..text=Variables.userName!,
                          decoration: CustomDecoration(hint: 'Enter username'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 10, 5, 0),
                        child: Text(
                          'Change Email',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                        child: TextFormField(
                           style: const TextStyle(color: Colors.white,fontSize: 17),
                          controller: _email,
                          decoration: CustomDecoration(hint: 'Your email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 10, 5, 0),
                        child: Text(
                          'Change password',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                        child: TextFormField(
                           style: const TextStyle(color: Colors.white,fontSize: 17),
                           controller: _password,
                          decoration: CustomDecoration(hint: 'enter password'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style:const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Variables.mColor)),
                      onPressed: () {
                      
                    }, child: Text('Update',style: Variables.mStyle,)),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
